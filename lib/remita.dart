import 'package:remita_flutter_sdk/generic/apiList.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';

import 'generic/hashGenerator.dart';
import 'generic/httpCalls.dart';
import 'responseObjects/chargeObject.dart';
import 'responseObjects/statusObject.dart';

class RemitaHandler {
  final String merchantID;
  final String apiKey;
  RemitaHandler({
    required this.apiKey,
    required this.merchantID,
  });

  ///RRR  Generation
  ///
  ///You can use our Generate RRR (with Custom Field) API to generate an RRR
  ///with custom field values.
  ///Custom fields are additional fields associated with the service type for which the RRR is being generated.
  Future<RemitaChargeResponse> generateRRR({
    required String serviceID,
    required String amount,
    required String orderID,
    required String payerName,
    required String payerEmail,
    required String payerPhone,
    required String description,
    List<CustomField>? customFields,
    List<Beneficiary>? lineItems,
  }) async {
    Map<String, dynamic> body = {
      "serviceTypeId": serviceID,
      "amount": amount,
      "orderId": orderID,
      "payerName": payerName,
      "payerEmail": payerEmail,
      "payerPhone": payerPhone,
      "description": description,
    };

    if (customFields != null)
      body['customFields'] = CustomField.castList(customFields);
    if (lineItems != null) body["lineItems"] = Beneficiary.castList(lineItems);
    List<String> hashableString = [
      merchantID,
      serviceID,
      orderID,
      amount,
      apiKey
    ];

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'remitaConsumerKey=$merchantID,remitaConsumerToken=${returnHash(hashableString)}'
    };

    return RemitaChargeResponse.fromJson(await GenericHttp.postToDB(
        api: RemitaAPI.generateRRR, body: body, headers: headers));
  }

// curl --location -g --request GET 'http://www.remitademo.net/remita/ecomm/{{merchantId}}/{{rrr}}/{{apiHash}}/status.reg' \
// --header 'Content-Type: application/json' \
// --header 'Authorization: remitaConsumerKey={{merchantId}},remitaConsumerToken={{apiHash}}'
  Future<RemitaStatusResponse> checkTransactionStatus(
      {String? rrr, String? orderID}) async {
    assert((orderID != null) | (rrr != null));
    List<String> hashableString = [rrr ?? orderID!, apiKey, merchantID];
    String api = rrr != null
        ? 'https://www.remitademo.net/remita/ecomm/$merchantID/$rrr/${returnHash(hashableString)}/status.reg'
        : 'https://remitademo.net/remita/exapp/api/v1/send/api/echannelsvc/$merchantID/$orderID/${returnHash(hashableString)}/orderstatus.reg';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'remitaConsumerKey=$merchantID,remitaConsumerToken=${returnHash(hashableString)}'
    };
    return RemitaStatusResponse.fromJson(await GenericHttp.getFromDB(
        api: api, apiKey: apiKey, headers: headers));
  }

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
      required String startDate,
      required String endDate,
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
      "startDate": startDate,
      "endDate": endDate,
      "mandateType": mandateType,
      "maxNoOfDebits": maxNoOfDebits,
    };
    if (customField != null)
      body["customFields"] = CustomField.castList(customField);

    return RemitaStatusResponse.fromJson(
        await GenericHttp.postToDB(api: RemitaAPI.generateMandate, body: body));
  }

  Future<RemitaStatusResponse> printMandate(
      {required String requestId, required String mandateId}) async {
    List<String> hashableString = [merchantID, apiKey, requestId];
    String api =
        'https://www.remitademo.net/remita/ecomm/mandate/form/merchantID/${returnHash(hashableString)}/$mandateId/$requestId/rest.reg';
    return RemitaStatusResponse.fromJson(await GenericHttp.getFromDB(api: api));
  }

  Future<RemitaStatusResponse> activateMandate({
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
      'Authorization':
          'remitaConsumerKey=$merchantID,remitaConsumerToken=${returnHash(hashableString)}'
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

  ///
  ///
  ///

}
