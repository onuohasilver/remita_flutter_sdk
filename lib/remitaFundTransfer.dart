import 'package:remita_flutter_sdk/generic/apiList.dart';
import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/generic/hashGenerator.dart';
import 'package:remita_flutter_sdk/generic/httpCalls.dart';
import 'package:remita_flutter_sdk/remita_handler.dart';

import 'responseObjects/fundTransferResponse.dart';

class RemitaFundTransfer extends RemitaHandler {
  final String merchantID, apiKey, encodeIv, encodeKey, apiToken;
  final bool demo;

  RemitaFundTransfer({
    required this.apiToken,
    required this.merchantID,
    this.demo = true,
    required this.apiKey,
    required this.encodeIv,
    required this.encodeKey,
  }) : super(merchantID: merchantID, demo: demo, apiKey: apiKey);

  ///This API facilitates funds transfer from one bank account to another.
  Future<FundTransferResponse> singleTransfer({
    required String beneficiaryBankCode,
    required String creditAccount,
    required String debitAccount,
    required String narration,
    required int amount,
    required String transRef,
    required String requestId,
    required String senderBankCode,
    String? beneficiaryEmail,
  }) async {
    Encryption encryption =
        Encryption(encodeIv: encodeIv, encodeKey: encodeKey);
    String apiAttachment = '/rpgsvc/rpg/api/v2/merc/payment/singlePayment.json';
    String api = RemitaAPI(demo).invoiceGenerationBase + apiAttachment;
    Map<String, dynamic> body = {
      "toBank": beneficiaryBankCode,
      "creditAccount": creditAccount,
      "narration": narration,
      "amount": amount,
      "transRef": transRef,
      "fromBank": senderBankCode,
      "debitAccount": debitAccount,
      "beneficiaryEmail": beneficiaryEmail
    };
    List<String> hashableString = [apiKey, requestId, apiToken];

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'MERCHANT_ID': merchantID,
      'API_KEY': apiKey,
      'REQUEST_ID': requestId,
      'REQUEST_TS': requestTS(),
      'API_DETAILS_HASH': Encryption.sha512Encrypt(hashableString)
    };

    ///Encrypt all the values in the body param
    body.forEach((key, value) {
      body[key] = encryption.aesEncrypt(value);
    });
    return FundTransferResponse.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }
}
