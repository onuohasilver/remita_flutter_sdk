import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class RemitaMandateStatus extends RemitaResponse {
  final String statusCode, status, mandateId, requestId;
  final DateTime endDate, startDate, activationDate, registrationDate;
  final bool isActive;

  ///Dart Object representation of the response gotten from
  ///a RemitaMandate status request
  RemitaMandateStatus({
    required this.requestId,
    required this.registrationDate,
    required this.endDate,
    required this.startDate,
    required this.statusCode,
    required this.status,
    required this.mandateId,
    required this.activationDate,
    required this.isActive,
  }) : super(statusCode, status);

  factory RemitaMandateStatus.fromJson(Map json) {
    return RemitaMandateStatus(
        requestId: json['requestId'],
        registrationDate: convertDate(json['registrationDate']),
        endDate: convertDate(json['endDate']),
        startDate: convertDate(json['startDate']),
        statusCode: json['statusCode'],
        status: json['status'],
        mandateId: json['mandateId'],
        activationDate: convertDate(json['activationDate']),
        isActive: json['isActive']);
  }

  @override
  String toString() {
    Map stringRep = {
      'requestId': requestId,
      'registrationDate': registrationDate,
      'endDate': endDate,
      'startDate': startDate,
      'statusCode': statusCode,
      'status': status,
      'mandateId': mandateId,
      'activationDate': activationDate,
      'isActive': isActive
    };
    return stringRep.toString();
  }
}
