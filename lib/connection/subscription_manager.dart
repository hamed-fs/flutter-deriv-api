import 'dart:async';

import 'package:flutter_deriv_api/api/request.dart';
import 'package:flutter_deriv_api/api/response.dart';
import 'package:flutter_deriv_api/api/api.helper.dart';
import 'package:flutter_deriv_api/api/forget_send.dart';
import 'package:flutter_deriv_api/api/forget_receive.dart';
import 'package:flutter_deriv_api/api/forget_all_send.dart';
import 'package:flutter_deriv_api/api/forget_all_receive.dart';
import 'package:flutter_deriv_api/connection/pending_request.dart';
import 'package:flutter_deriv_api/connection/base_call_manager.dart';
import 'package:flutter_deriv_api/connection/subscription_stream.dart';
import 'package:flutter_deriv_api/connection/connection_websocket.dart';
import 'package:flutter_deriv_api/connection/pending_subscribed_request.dart';

/// Subscription manager class
class SubscriptionManager extends BaseCallManager<Stream<Response>> {
  /// Class constructor
  SubscriptionManager(BinaryAPI api) : super(api);

  /// Get subscription id
  String getSubscriptionId(int requestId) {
    final PendingRequest<Response> pendingRequest = pendingRequests[requestId];

    return pendingRequest is PendingSubscribedRequest<Response>
        ? pendingRequest.subscriptionId
        : null;
  }

  /// Get subscription stream
  SubscriptionStream<Response> getSubscriptionStream(int requestId) {
    final PendingRequest<Response> pendingRequest = pendingRequests[requestId];

    return pendingRequest is PendingSubscribedRequest<Response>
        ? pendingRequest.subscriptionStream
        : null;
  }

  /// Set subscription id
  void setSubscriptionId({
    int requestId,
    String subscriptionId,
  }) =>
      pendingRequests[requestId] = PendingSubscribedRequest<Response>()
          .copyWith(subscriptionId: subscriptionId);

  /// Set subscription stream
  void setSubscriptionStream({
    int requestId,
    SubscriptionStream<Response> subscriptionStream,
  }) =>
      pendingRequests[requestId] = PendingSubscribedRequest<Response>()
          .copyWith(subscriptionStream: subscriptionStream);

  @override
  void handleResponse({
    int requestId,
    Map<String, dynamic> response,
  }) {
    super.handleResponse(requestId: requestId, response: response);

    // Adds the subscription id to the pending request object for further references
    if (response.containsKey('subscription')) {
      setSubscriptionId(
        requestId: requestId,
        subscriptionId: response['subscription']['id'],
      );
    }

    // Broadcasts the new message into the stream.
    getSubscriptionStream(requestId).add(getResponseByMsgType(response));

    print('response added to stream.');
  }

  @override
  Stream<Response> call(Request request) {
    // TODO(hamed): we should check request duplication before another api call

    _call(request);

    final SubscriptionStream<Response> subscriptionStream =
        SubscriptionStream<Response>();

    pendingRequests[request.reqId] = PendingSubscribedRequest<Response>()
        .copyWith(subscriptionStream: subscriptionStream);

    return subscriptionStream.stream;
  }

  /// unsubscribe with a specific [subscriptionId]
  Future<ForgetResponse> unsubscribe(
    String subscriptionId, {
    bool shouldForced = false,
  }) async {
    final int requestId = pendingRequests.keys
        .singleWhere((int id) => getSubscriptionId(id) == subscriptionId);

    if (getSubscriptionStream(requestId).hasListener && !shouldForced) {
      throw Exception('The stream has listener');
    }

    // Send forget request
    final Response response = await api.callManager.call(
      ForgetRequest(forget: getSubscriptionId(requestId)),
    );

    if (response.error == null) {
      await _removePendingRequest(requestId);
    }

    return response;
  }

  /// Unsubscribe to multiple [method]s all at once
  Future<dynamic> unsubscribeAll(
    String method, {
    bool shouldForced = false,
  }) async {
    final List<int> requestIds = pendingRequests.keys.where(
      (int id) {
        final PendingRequest<Response> pendingRequest = pendingRequests[id];

        return pendingRequest is PendingSubscribedRequest<Response> &&
            pendingRequest.method == method &&
            pendingRequest.isSubscribed;
      },
    );

    final ForgetAllResponse response =
        await api.callManager.call(ForgetAllRequest(forgetAll: method));

    if (response.error == null) {
      for (int id in requestIds) {
        await _removePendingRequest(id);
      }
    }

    return response;
  }

  Future<Response> _call(Request request) {
    request.reqId = nextRequestId;

    final Map<String, dynamic> preparedRequest = request.toJson()
      ..removeWhere((String key, dynamic value) => value == null)
      ..putIfAbsent('subscribe', () => 1);

    return prepareRequest(
      requestId: request.reqId,
      request: preparedRequest,
    );
  }

  Future<void> _removePendingRequest(int requestId) async {
    await getSubscriptionStream(requestId).closeStream();

    pendingRequests.remove(requestId);
  }
}
