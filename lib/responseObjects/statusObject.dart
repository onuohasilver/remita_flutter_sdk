import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class RemitaStatusResponse extends RemitaResponse {
  final String? rrr,
      orderID,
      message,
      transactionTime,
      remitaTransRef,
      requestId,
      mandateId;
  final double amount;
  final List authParams;
  final String status, statusCode;

  RemitaStatusResponse(
      {required this.amount,
      required this.rrr,
      required this.requestId,
      required this.mandateId,
      required this.orderID,
      required this.authParams,
      required this.remitaTransRef,
      required this.message,
      required this.transactionTime,
      required this.statusCode,
      required this.status})
      : super(statusCode, status);
  factory RemitaStatusResponse.fromJson(Map json) => RemitaStatusResponse(
        amount: json['amount'],
        message: json['message'],
        remitaTransRef: json['remitaTransRef'],
        authParams: json['authParams'],
        orderID: json['orderId'],
        rrr: json['RRR'],
        statusCode: json['statusCode'],
        status: json['status'],
        transactionTime: json['transactiontime'],
        requestId: json['requestId'],
        mandateId: json['mandateId'],
      );
}
