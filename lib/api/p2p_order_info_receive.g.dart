// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p_order_info_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

P2pOrderInfoResponse _$P2pOrderInfoResponseFromJson(Map<String, dynamic> json) {
  return P2pOrderInfoResponse(
    p2pOrderInfo: json['p2p_order_info'] as Map<String, dynamic>,
    subscription: json['subscription'] as Map<String, dynamic>,
    reqId: json['req_id'] as int,
    msgType: json['msg_type'] as String,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$P2pOrderInfoResponseToJson(
        P2pOrderInfoResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'msg_type': instance.msgType,
      'echo_req': instance.echoReq,
      'error': instance.error,
      'p2p_order_info': instance.p2pOrderInfo,
      'subscription': instance.subscription,
    };
