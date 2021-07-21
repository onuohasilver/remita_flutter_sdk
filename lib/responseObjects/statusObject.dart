class RemitaStatusResponse {
  final String? rrr,
      orderID,
      message,
      transactionTime,
      status,
      remitaTransRef,
      requestId,
      mandateId;
  final double amount;
  final List authParams;

  const RemitaStatusResponse(
      {required this.amount,
      required this.rrr,
      required this.requestId,
      required this.mandateId,
      required this.orderID,
      required this.authParams,
      required this.remitaTransRef,
      required this.message,
      required this.transactionTime,
      required this.status});
  factory RemitaStatusResponse.fromJson(Map json) => RemitaStatusResponse(
        amount: json['amount'],
        message: json['message'],
        remitaTransRef:json['remitaTransREf'],
        authParams: json['authParams'],
        orderID: json['orderId'],
        rrr: json['RRR'],
        status: json['status'],
        transactionTime: json['transactiontime'],
        requestId: json['requestId'],
        mandateId: json['mandateId'],
      );
}
