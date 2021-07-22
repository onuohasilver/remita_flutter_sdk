import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateDataObject.dart';
import 'package:remita_flutter_sdk/responseObjects/mandatePaymentObject.dart';

class MandateHistoryObject extends RemitaResponse {
  final String statusCode, status, requestId, mandateId;
  final MandateData data;

  MandateHistoryObject({
    required this.statusCode,
    required this.requestId,
    required this.mandateId,
    required this.data,
    required this.status,
  }) : super(statusCode, status);

  factory MandateHistoryObject.fromJson(Map json) {
    return MandateHistoryObject(
      statusCode: json['statusCode'],
      mandateId: json['mandateId'],
      requestId: json['requestId'],
      data: MandateData.fromJson(json['data']),
      status: json['status'],
    );
  }
}
