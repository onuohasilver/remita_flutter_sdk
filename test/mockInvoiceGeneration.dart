import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';

class MockInvoiceGeneration {
  static String apiKey = '1946';
  static String serviceId = '4430731';
  static String merchantId = '2547916';
  static String amount = '10000';
  static String payerName = 'Adekunle Ciroma';
  static String payerEmail = 'Adekunle Chukwuma Ciroma';
  static String payerPhone = '09087623422';
  static String description = 'Payment For Orange GoldFish';
  static List<CustomField> customFields = [
    CustomField(name: "Payer TIN", value: "1234567890", type: "ALL"),
    CustomField(value: '2018/06/27', name: 'Contract Date', type: 'ALL')
  ];

  static List<Beneficiary> beneficiaryFields = [
    Beneficiary(
        linesItemId: "itemid1",
        beneficiaryName: "Alozie Michael",
        beneficiaryAccount: "6020067886",
        bankCode: "058",
        beneficiaryAmount: "7000",
        deductFeeFrom: "1"),
    Beneficiary(
        linesItemId: "itemid2",
        beneficiaryName: "Folivi Joshua",
        beneficiaryAccount: "0360883515",
        bankCode: "058",
        beneficiaryAmount: "3000",
        deductFeeFrom: "0")
  ];
}
