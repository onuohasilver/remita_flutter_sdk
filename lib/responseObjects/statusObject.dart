import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class RemitaStatusResponse extends RemitaResponse {
  final String? rrr,
      orderID,
      message,
      transactionTime,
      transactionRef,
      requestId,
      mandateId;
  final double? amount;
  final List? authParams;
  final String status, statuscode;
  final DateTime? lastStatusUpdateTime;

  RemitaStatusResponse(
      {required this.amount,
      required this.lastStatusUpdateTime,
      required this.rrr,
      required this.requestId,
      required this.mandateId,
      required this.orderID,
      required this.authParams,
      required this.transactionRef,
      required this.message,
      required this.transactionTime,
      required this.statuscode,
      required this.status})
      : super(statuscode, status);
  factory RemitaStatusResponse.fromJson(Map json) => RemitaStatusResponse(
        amount: json['amount'],
        message: json['message'],
        lastStatusUpdateTime: json['lastStatusUpdateTime'] != null
            ? convertDate(json['lastStatusUpdateTime'])
            : null,
        transactionRef: json['transactionRef'],
        authParams: json['authParams'],
        orderID: json['orderId'],
        rrr: json['RRR'],
        statuscode: json['statuscode'],
        status: json['status'],
        transactionTime: json['transactiontime'],
        requestId: json['requestId'],
        mandateId: json['mandateId'],
      );
}
