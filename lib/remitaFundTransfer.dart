import 'package:remita_flutter_sdk/generic/apiList.dart';
import 'package:remita_flutter_sdk/remita_handler.dart';
import 'package:encrypt/encrypt.dart';

class RemitaFundTransfer extends RemitaHandler {
  final String merchantID, apiKey;
  final bool demo;

  RemitaFundTransfer(
      {required this.merchantID, required this.demo, required this.apiKey})
      : super(merchantID: merchantID, demo: demo, apiKey: apiKey);

  ///This API facilitates funds transfer from one bank account to another.
  Future singleTransfer({
    required String beneficiaryBankCode,
    required String creditAccount,
    required String debitAccount,
    required String narration,
    required int amount,
    required String transRef,
    required String senderBankCode,
    String? beneficiaryEmail,
  }) async {
    String apiAttachment = '/rpgsvc/rpg/api/v2/merc/payment/singlePayment.json';
    String api = RemitaAPI(demo).invoiceGenerationBase + apiAttachment;
    Map<String, dynamic> body = {
      "toBank": beneficiaryBankCode,
      "creditAccount": creditAccount,
      "narration": narration,
      "amount": amount,
      "transRef": transRef,
      "fromBank": "{{fromBank}}",
      "debitAccount": "{{debitAccount}}",
      "beneficiaryEmail": "{{beneficiaryEmail}}"
    };
  }
}
