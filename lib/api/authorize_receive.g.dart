// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorize_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizeResponse _$AuthorizeResponseFromJson(Map<String, dynamic> json) {
  return AuthorizeResponse(
    authorize: json['authorize'] as Map<String, dynamic>,
    reqId: json['req_id'] as int,
    msgType: json['msg_type'] as String,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AuthorizeResponseToJson(AuthorizeResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'msg_type': instance.msgType,
      'echo_req': instance.echoReq,
      'error': instance.error,
      'authorize': instance.authorize,
    };
