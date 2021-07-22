import 'package:remita_flutter_sdk/remita_handler.dart';
import 'generic/apiList.dart';
import 'generic/genericTypes/customFields.dart';
import 'generic/hashGenerator.dart';
import 'generic/httpCalls.dart';
import 'responseObjects/statusObject.dart';

class RemitaDirectDebit extends RemitaHandler {
  final String merchantID;
  final String apiKey;
  final bool demo;

  RemitaDirectDebit(
      {required this.merchantID, required this.apiKey, required this.demo})
      : super(merchantID: merchantID, apiKey: apiKey);

  /// [endDate]
  /// This is when the mandate expires. Direct   debit instructions are no longer issuable on it.
  /// (Format: DD/MM/YYYY)
  Future<RemitaStatusResponse> generateMandate(
      {required String serviceID,
      required String requestId,
      required String amount,
      required String payerName,
      required String payerEmail,
      required String payerPhone,
      required String payerBankCode,
      required String payerAccount,
      required DateTime startDate,
      required DateTime endDate,
      required String mandateType,
      required String maxNoOfDebits,
      List<CustomField>? customField}) async {
    List<String> hashableString = [
      merchantID,
      serviceID,
      requestId,
      amount,
      apiKey
    ];

    Map<String, dynamic> body = {
      "merchantId": merchantID,
      "serviceTypeId": serviceID,
      "requestId": requestId,
      "hash": returnHash(hashableString),
      "payerName": payerName,
      "payerEmail": payerEmail,
      "payerPhone": payerPhone,
      "payerBankCode": payerBankCode,
      "payerAccount": payerAccount,
      "amount": amount,
      "startDate": "${startDate.day}" +
          "/" +
          "${startDate.month}" +
          "/" +
          "${startDate.year}",
      "endDate": "${startDate.day}" +
          "/" +
          "${startDate.month}" +
          "/" +
          "${startDate.year}",
      "mandateType": mandateType,
      "maxNoOfDebits": maxNoOfDebits,
    };
    if (customField != null)
      body["customFields"] = CustomField.castList(customField);
    String apiAttachment = '/echannelsvc/echannel/mandate/setup';
    String api = RemitaAPI(demo).directDebitPostBase + apiAttachment;

    return RemitaStatusResponse.fromJson(
        await GenericHttp.postToDB(api: api, body: body));
  }

  Future<RemitaStatusResponse> printMandate(
      {required String requestId, required String mandateId}) async {
    List<String> hashableString = [merchantID, apiKey, requestId];
    String api =
        'https://www.remitademo.net/remita/ecomm/mandate/form/merchantID/${returnHash(hashableString)}/$mandateId/$requestId/rest.reg';
    return RemitaStatusResponse.fromJson(await GenericHttp.getFromDB(api: api));
  }

  Future<RemitaStatusResponse> mandateOTPrequest({
    required String apiToken,
    required String requestId,
    required String mandateId,
  }) async {
    List<String> hashableString = [apiKey, requestId, apiToken];

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'MERCHANT_ID': merchantID,
      'API_KEY': apiKey,
      'REQUEST_ID': requestId,
      'REQUEST_TS': DateTime.now().toIso8601String(),
      'API_DETAILS_HASH': returnHash(hashableString),
    };

    Map<String, dynamic> body = {
      "mandateId": mandateId,
      "requestId": requestId
    };
    String api =
        'https://remitademo.net/remita/exapp/api/v1/send/api/echannelsvc/echannel/mandate/requestAuthorization';

    return RemitaStatusResponse.fromJson(await GenericHttp.postToDB(
      api: api,
      body: body,
      headers: headers,
    ));
  }

  ///This method is applicable to Payers whose funding bank is integrated to the Remita Platform for One Time Password (OTP) authentication. Such users will be able to activate direct debit mandates directly on your portal.

  ///This request triggers the Payer's
  ///bank to send their requirements for automated mandate activation.

  mandateOTPactivate(
      {required String merchantID,
      required String requestId,
      required String remitaTransferRef,
      required String otp,
      required String card,
      required String apiToken}) async {
    String api =
        'https://remitademo.net/remita/exapp/api/v1/send/api/echannelsvc/echannel/mandate/validateAuthorization';

    List<String> hashableString = [
      apiKey,
      requestId,
      apiToken,
    ];

    /// For
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'MERCHANT_ID': merchantID,
      'API_KEY': apiKey,
      'REQUEST_ID': requestId,
      'REQUEST_TS': DateTime.now().toIso8601String(),
      'API_DETAILS_HASH': returnHash(hashableString)
    };

    ///
    Map<String, dynamic> body = {
      "remitaTransRef": remitaTransferRef,
      "authParams": [
        {"param1": "OTP", "value": otp},
        {"param2": "CARD", "value": card}
      ]
    };
    return RemitaStatusResponse.fromJson(await GenericHttp.postToDB(
      api: api,
      body: body,
      headers: headers,
    ));
  }

  checkMandateStatus() async {}
}
