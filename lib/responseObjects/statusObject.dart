class RemitaStatusResponse {
  final String? rrr,
      orderID,
      message,
      transactionTime,
      status,
      requestId,
      mandateId;
  final double amount;

  const RemitaStatusResponse(
      {required this.amount,
      required this.rrr,
      required this.requestId,
      required this.mandateId,
      required this.orderID,
      required this.message,
      required this.transactionTime,
      required this.status});
  factory RemitaStatusResponse.fromJson(Map json) => RemitaStatusResponse(
        amount: json['amount'],
        message: json['message'],
        orderID: json['orderId'],
        rrr: json['RRR'],
        status: json['status'],
        transactionTime: json['transactiontime'],
        requestId: json['requestId'],
        mandateId: json['mandateId'],
      );
}
