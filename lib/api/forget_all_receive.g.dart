// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_all_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetAllResponse _$ForgetAllResponseFromJson(Map<String, dynamic> json) {
  return ForgetAllResponse(
    forgetAll: (json['forget_all'] as List).map((e) => e as String).toList(),
    reqId: json['req_id'] as int,
    msgType: json['msg_type'] as String,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ForgetAllResponseToJson(ForgetAllResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'msg_type': instance.msgType,
      'echo_req': instance.echoReq,
      'error': instance.error,
      'forget_all': instance.forgetAll,
    };
