import 'package:remita_flutter_sdk/generic/dateConverter.dart';

class FundTransferResponse {
  final String? status,
      responsecode,
      authorizationId,
      responseId,
      response,
      transRef,
      rrr;
  final dynamic data;

  final DateTime? transDate, paymentDate;

  FundTransferResponse({
    required this.transRef,
    required this.status,
    required this.data,
    required this.responsecode,
    required this.authorizationId,
    required this.responseId,
    required this.response,
    required this.rrr,
    required this.transDate,
    required this.paymentDate,
  });
  factory FundTransferResponse.fromJson(Map json) {
    Map data = json['data'];
    return FundTransferResponse(
        status: json['status'],
        data: data['data'],
        responsecode: data['responsecode'],
        authorizationId: data['authorizationId'],
        responseId: data['responseId'],
        response: data['responseDescription'],
        rrr: data['rrr'],
        transDate:
            data['transDate'] != null ? convertDate(data['transDate']) : null,
        paymentDate: data['paymentDate'] != null
            ? convertDate(data['paymentDate'])
            : null,
        transRef: data['transRef']);
  }

  @override
  String toString() {
    return {
      "status": status,
      "authorizationId": authorizationId,
      "transRef": transRef,
      "transDate": transDate,
      "paymentDate": paymentDate,
      "responseId": responseId,
      "responseCode": responsecode,
      "responseDescription": response,
      "rrr": rrr,
      "data": data
    }.toString();
  }
}
