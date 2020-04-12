/// generated automatically from flutter_deriv_api|lib/api/ticks_receive.json
import 'package:json_annotation/json_annotation.dart';

import 'response.dart';

part 'ticks_receive.g.dart';

/// JSON conversion for 'ticks_receive'
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class TicksResponse extends Response {
  /// Initialize TicksResponse
  TicksResponse({
    this.subscription,
    this.tick,
    int reqId,
    String msgType,
    Map<String, dynamic> echoReq,
    Map<String, dynamic> error,
  }) : super(
          reqId: reqId,
          msgType: msgType,
          echoReq: echoReq,
          error: error,
        );

  /// Creates instance from JSON
  factory TicksResponse.fromJson(Map<String, dynamic> json) =>
      _$TicksResponseFromJson(json);

  // Properties
  /// For subscription requests only.
  final Map<String, dynamic> subscription;

  /// Tick by tick list of streamed data
  final Map<String, dynamic> tick;

  /// Converts to JSON
  @override
  Map<String, dynamic> toJson() => _$TicksResponseToJson(this);

  /// Creates copy of instance with given parameters
  @override
  TicksResponse copyWith({
    Map<String, dynamic> subscription,
    Map<String, dynamic> tick,
    int reqId,
    String msgType,
    Map<String, dynamic> echoReq,
    Map<String, dynamic> error,
  }) =>
      TicksResponse(
        subscription: subscription ?? this.subscription,
        tick: tick ?? this.tick,
        reqId: reqId ?? this.reqId,
        msgType: msgType ?? this.msgType,
        echoReq: echoReq ?? this.echoReq,
        error: error ?? this.error,
      );
}
