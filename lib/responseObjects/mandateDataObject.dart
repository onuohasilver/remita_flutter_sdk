import 'package:remita_flutter_sdk/responseObjects/mandatePaymentObject.dart';

class MandateData {
  final int? totalAmount, totalTransactionCount;
  final List<MandatePaymentObject>? paymentDetails;

  MandateData({
    required this.totalTransactionCount,
    required this.totalAmount,
    required this.paymentDetails,
  });

  factory MandateData.fromJson(Map json) {
    return MandateData(
        totalTransactionCount: json['totalTransactionCount'],
        totalAmount: json['totalAmount'],
        paymentDetails: json['paymentDetails'] != null
            ? List.generate(
                json['paymentDetails'].length,
                (index) => MandatePaymentObject.fromJson(
                    json['paymentDetails'][index]))
            : null);
  }
}
