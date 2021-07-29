import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class RemitaStatusResponse extends RemitaResponse {
  final String? rrr, orderID, message, requestId, mandateId;
  // final double? amount;
  final List? authParams;
  final int? transactionRef;
  final String? amount;
  final String? status, statuscode, remitaTransRef;
  final DateTime? lastStatusUpdateTime, transactionTime;

  RemitaStatusResponse(
      {required this.amount,
      required this.remitaTransRef,
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
        amount: json['amount'].toString(),
        message: json['message'],
        lastStatusUpdateTime: json['lastStatusUpdateTime'] != null
            ? convertDate(json['lastStatusUpdateTime'])
            : null,
        transactionRef: json['transactionRef'],
        authParams: json['authParams'],
        orderID: json['orderId'],
        remitaTransRef: json['remitaTransRef'],
        rrr: json['RRR'],
        statuscode: json['statuscode'],
        status: json['status'],
        transactionTime: json['transactiontime'] != null
            ? convertDate(json['transactiontime'])
            : null,
        requestId: json['requestId'],
        mandateId: json['mandateId'],
      );

  @override
  String toString() {
    return {
      'amount': amount,
      'message': message,
      'lastStatusUpdateTime': lastStatusUpdateTime,
      'transactionRef': transactionRef,
      'Remita trans Ref': remitaTransRef,
      'authParams': authParams,
      'orderID': orderID,
      'rrr': rrr,
      'statuscode': statuscode,
      'status': status,
      'transactionTime': transactionTime,
      'requestId': requestId,
      'mandateId': mandateId,
    }.toString();
  }
}
