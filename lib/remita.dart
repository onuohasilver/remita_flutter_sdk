import 'generic/hashGenerator.dart';
import 'generic/httpCalls.dart';
import 'responseObjects/chargeObject.dart';

class RemitaHandler {
  final String merchantID;
  final String apiKey;
  RemitaHandler({
    required this.apiKey,
    required this.merchantID,
  });

  ///Invoice Generation
  Future<RemitaChargeResponse> generateRRR(
      String serviceID,
      String amount,
      String orderID,
      String payerName,
      String payerEmail,
      String payerPhone,
      String description) async {
    String api =
        'https://remitademo.net/remita/exapp/api/v1/send/api/echannelsvc/merchant/api/paymentinit';

    Map<String, dynamic> body = {
      "serviceTypeId": serviceID,
      "amount": amount,
      "orderId": orderID,
      "payerName": payerName,
      "payerEmail": payerEmail,
      "payerPhone": payerPhone,
      "description": description
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

    return RemitaChargeResponse.fromJson(
        await GenericHttp.postToDB(api: api, body: body, headers: headers));
  }

// curl --location -g --request GET 'http://www.remitademo.net/remita/ecomm/{{merchantId}}/{{rrr}}/{{apiHash}}/status.reg' \
// --header 'Content-Type: application/json' \
// --header 'Authorization: remitaConsumerKey={{merchantId}},remitaConsumerToken={{apiHash}}'
  Future checkTransactionStatus(String rrr) {
    List<String> hashableString = [rrr, apiKey, merchantID];
    String api =
        'https://www.remitademo.net/remita/ecomm/$merchantID/$rrr/${returnHash(hashableString)}/status.reg';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'remitaConsumerKey=$merchantID,remitaConsumerToken=${returnHash(hashableString)}'
    };
    return GenericHttp.getFromDB(api: api, apiKey: apiKey, headers: headers);
  }
}
