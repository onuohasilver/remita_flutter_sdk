import 'package:remita_flutter_sdk/generic/apiList.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/remita_handler.dart';

import 'generic/hashGenerator.dart';
import 'generic/httpCalls.dart';
import 'responseObjects/chargeObject.dart';
import 'responseObjects/statusObject.dart';

class RemitaInvoiceGeneration extends RemitaHandler {
  final String merchantID;
  final String apiKey;
  final bool demo;

  RemitaInvoiceGeneration({
    required this.apiKey,
    required this.merchantID,
    this.demo = true,
  }) : super(apiKey: apiKey, merchantID: merchantID, demo: demo);

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
    String apiAttachment = '/echannelsvc/merchant/api/paymentinit';

    return RemitaChargeResponse.fromJson(await GenericHttp.postToDB(
        api: RemitaAPI(demo).invoiceGenerationBase + apiAttachment,
        body: body,
        headers: headers));
  }

// curl --location -g --request GET 'http://www.remitademo.net/remita/ecomm/{{merchantId}}/{{rrr}}/{{apiHash}}/status.reg' \
// --header 'Content-Type: application/json' \
// --header 'Authorization: remitaConsumerKey={{merchantId}},remitaConsumerToken={{apiHash}}'
  Future<RemitaStatusResponse> checkTransactionStatus(
      {String? rrr, String? orderID}) async {
    assert((orderID != null) | (rrr != null));
    List<String> hashableString = [rrr ?? orderID!, apiKey, merchantID];

    ///The attachement to be added to the tail end of the base Url when checking
    ///transaction status using OrderID
    String apiAttachmentRRR =
        '/$merchantID/$rrr/${returnHash(hashableString)}/status.reg';

    ///The attachement to be added to the tail end of the base Url when checking
    ///transaction status using RRR
    String apiAttachmentOrderID =
        '/echannelsvc/$merchantID/$orderID/${returnHash(hashableString)}/orderstatus.reg';

    ///Combining the baseUrl and the api Attachment
    String api = RemitaAPI(demo).directDebitGetBase +
        (rrr != null ? apiAttachmentRRR : apiAttachmentOrderID);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'remitaConsumerKey=$merchantID,remitaConsumerToken=${returnHash(hashableString)}'
    };
    return RemitaStatusResponse.fromJson(await GenericHttp.getFromDB(
        api: api, apiKey: apiKey, headers: headers));
  }
}
