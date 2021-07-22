import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/responseObjects/genericResponse.dart';

class RemitaMandateStatus extends RemitaResponse {
  final String? mandateId, requestId, statuscode, status;
  final DateTime? endDate, startDate, activationDate, registrationDate;
  final bool? isActive;

  ///Dart Object representation of the response gotten from
  ///a RemitaMandate status request
  RemitaMandateStatus(
      {required this.requestId,
      required this.registrationDate,
      required this.endDate,
      required this.startDate,
      required this.mandateId,
      required this.activationDate,
      required this.isActive,
      required this.status,
      required this.statuscode})
      : super(statuscode, status);

  factory RemitaMandateStatus.fromJson(Map json) {
    return RemitaMandateStatus(
        requestId: json['requestId'],
        registrationDate: convertDate(json['registrationDate']),
        endDate: convertDate(json['endDate']),
        startDate: convertDate(json['startDate']),
        status: json['status'],
        statuscode: json['statuscode'],
        mandateId: json['mandateId'],
        activationDate: json['activationDate'] != null
            ? convertDate(json['activationDate'])
            : null,
        isActive: json['isActive']);
  }

  @override
  String toString() {
    Map stringRep = {
      'requestId': requestId,
      'registrationDate': registrationDate,
      'endDate': endDate,
      'startDate': startDate,
      'mandateId': mandateId,
      'activationDate': activationDate,
      'isActive': isActive
    };
    return stringRep.toString();
  }
}
