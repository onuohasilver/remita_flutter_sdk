import 'dart:convert';

import 'package:remita_flutter_sdk/remita_handler.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateHistoryObject.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateStatus.dart';
import 'generic/apiList.dart';
import 'generic/dateConverter.dart';
import 'generic/genericTypes/customFields.dart';
import 'generic/hashGenerator.dart';
import 'generic/httpCalls.dart';
import 'responseObjects/statusObject.dart';

class RemitaDirectDebit extends RemitaHandler {
  final String merchantID;
  final String apiKey;
  final bool demo;

  RemitaDirectDebit(
      {required this.merchantID, required this.apiKey, this.demo = true})
      : super(merchantID: merchantID, apiKey: apiKey, demo: demo);

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
      "startDate": "${startDate.month}" +
          '/' +
          "${startDate.day}" +
          '/' +
          "${startDate.year}",
      "endDate":
          "${endDate.month}" + '/' + "${endDate.day}" + '/' + "${endDate.year}",
      "mandateType": mandateType,
      "maxNoOfDebits": maxNoOfDebits,
    };
    if (customField != null)
      body["customFields"] = CustomField.castList(customField);
    String apiAttachment = '/echannelsvc/echannel/mandate/setup';
    String api = RemitaAPI(demo).directDebitPostBase + apiAttachment;

    Map<String, String> headers = {'Content-Type': 'application/json'};

    return RemitaStatusResponse.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }

  ///Print out the Mandate HTML form
  ///
  ///Such payers will need to take a
  ///printed and sigened mandate to their bank branch
  ///(or send through their account manager)
  ///for activation before you are able to issue
  ///direct debit instructions on the mandate successfully.
  Future<Uri> printMandate(
      {required String requestId, required String mandateId}) async {
    List<String> hashableString = [merchantID, apiKey, requestId];
    String apiAttachment =
        '/mandate/form/$merchantID/${returnHash(hashableString)}/$mandateId/$requestId/rest.reg';
    String api = RemitaAPI(demo).directDebitGetBase + apiAttachment;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    late Uri uri;
    await GenericHttp.getFromDB(api: api, headers: headers, isHtml: true)
        .then((value) => uri = Uri.dataFromString(value.toString()));

    return uri;
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
      'REQUEST_TS': requestTS(),
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

  ///This method is applicable to Payers whose funding bank is integrated to the Remita Platform
  /// for One Time Password (OTP) authentication.
  /// Such users will be able to activate direct debit mandates directly on your portal.
  ///This request triggers the Payer's
  ///bank to send their requirements for automated mandate activation.

  Future<RemitaStatusResponse> mandateOTPactivate(
      {required String requestId,
      required String remitaTransferRef,
      required String otp,
      required String card,
      required String apiToken}) async {
    String apiAttachment =
        '/echannelsvc/echannel/mandate/validateAuthorization';
    String api = RemitaAPI(demo).invoiceGenerationBase + apiAttachment;

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
      'REQUEST_TS': requestTS(),
      'API_DETAILS_HASH': returnHash(hashableString)
    };

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

  Future<RemitaMandateStatus> checkMandateStatus(
      {required String requestId, required String mandateId}) async {
    List<String> hashableString = [mandateId, merchantID, requestId, apiKey];
    String apiAttachment = '/echannelsvc/echannel/mandate/status';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "merchantId": merchantID,
      "mandateId": mandateId,
      "hash": returnHash(hashableString),
      "requestId": requestId
    };

    String api = RemitaAPI(demo).directDebitPostBase + apiAttachment;
    return RemitaMandateStatus.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }

  ///This  allows you retrieve the history of a direct debit agreement and all debits that have been made.
  Future<MandateHistoryObject> mandatePaymentHistory({
    required String mandateId,
    required String requestId,
  }) async {
    String apiAttachment = '/echannelsvc/echannel/mandate/payment/history';
    String api = RemitaAPI(demo).directDebitPostBase + apiAttachment;
    List<String> hashableString = [mandateId, merchantID, requestId, apiKey];
    Map<String, dynamic> body = {
      "merchantId": merchantID,
      "mandateId": mandateId,
      "hash": returnHash(hashableString),
      "requestId": requestId
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    return MandateHistoryObject.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }

  ///This allows you to stop a mandate.
  Future<RemitaStatusResponse> stopMandate({
    required String mandateId,
    required String requestId,
  }) async {
    String apiAttachment = '/echannelsvc/echannel/mandate/stop';
    String api = RemitaAPI(demo).directDebitPostBase + apiAttachment;
    List<String> hashableString = [mandateId, merchantID, requestId, apiKey];
    Map<String, dynamic> body = {
      "merchantId": merchantID,
      "hash": returnHash(hashableString),
      "mandateId": mandateId,
      "requestId": requestId
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    return RemitaStatusResponse.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }
}
