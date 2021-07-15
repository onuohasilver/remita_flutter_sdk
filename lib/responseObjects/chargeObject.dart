class RemitaChargeResponse {
  const RemitaChargeResponse({
    required this.statusCode,
    required this.rrr,
    required this.status,
    required this.statusMessage,
  });
  final String? statusCode, rrr, status, statusMessage;

  factory RemitaChargeResponse.fromJson(Map json) => RemitaChargeResponse(
      status: json['status'],
      statusCode: json['statuscode'],
      statusMessage: json['statusmessage'],
      rrr: json['RRR']);

  @override
  String toString() {
    return {
      "status": status,
      "statusmessage": statusMessage,
      "rrr": rrr,
      "statusCode": statusCode
    }.toString();
  }
}
