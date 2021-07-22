import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class MandatePaymentObject extends RemitaResponse {
  final String statusCode, status, amount, rrr, transactionRef;
  final DateTime lastStatusUpdateTime;

  MandatePaymentObject({
    required this.status,
    required this.amount,
    required this.rrr,
    required this.transactionRef,
    required this.lastStatusUpdateTime,
    required this.statusCode,
  }) : super(statusCode, status);

  factory MandatePaymentObject.fromJson(json) {
    return MandatePaymentObject(
        status: json['status'],
        amount: json['amount'],
        rrr: json['rrr'],
        transactionRef: json['transactionRef'],
        lastStatusUpdateTime: convertDate(json['lastStatusUpdateTime']),
        statusCode: json['statusCode']);
  }
}
