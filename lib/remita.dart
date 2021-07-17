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
      "customFields": CustomField.castList(customFields),
      "lineItems": Beneficiary.castList(lineItems)
    };
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
}
