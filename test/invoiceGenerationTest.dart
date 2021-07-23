import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/getRandomString.dart';
import 'package:remita_flutter_sdk/remitaInvoiceGeneration.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';
import 'package:remita_flutter_sdk/responseObjects/statusObject.dart';

import 'mockApi.dart';
import 'mockInvoiceGeneration.dart';

invoiceGenerationTest() {
  RemitaInvoiceGeneration remitaInvoiceGeneration = RemitaInvoiceGeneration(
      apiKey: MockInvoiceGeneration.apiKey,
      merchantID: MockInvoiceGeneration.merchantId);

  late String rrr, orderId;

  group('', () {
    test('Create Mock RRR', () async {
      RemitaChargeResponse remitaChargeResponse =
          await Mock.generateRRR(MockData.rrrData);
      expect(remitaChargeResponse.rrr, '250008102864');
      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.status, "Payment Reference generated");
      expect(remitaChargeResponse.statusMessage, null);
    });

    test('Generate RRR', () async {
      RemitaChargeResponse remitaChargeResponse =
          await remitaInvoiceGeneration.generateRRR(
              serviceID: MockInvoiceGeneration.serviceId,
              amount: MockInvoiceGeneration.amount,
              orderID: getRandomString(9),
              payerName: MockInvoiceGeneration.payerName,
              payerEmail: MockInvoiceGeneration.payerEmail,
              payerPhone: MockInvoiceGeneration.payerPhone,
              description: MockInvoiceGeneration.description);
      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.rrr?.length == 12, true);
      expect(remitaChargeResponse.status, 'Payment Reference generated');
      rrr = remitaChargeResponse.rrr!;
    });

    test('Generate RRR with Custom Fields', () async {
      RemitaChargeResponse remitaChargeResponse =
          await remitaInvoiceGeneration.generateRRR(
              serviceID: MockInvoiceGeneration.serviceId,
              amount: MockInvoiceGeneration.amount,
              orderID: getRandomString(9),
              payerName: MockInvoiceGeneration.payerName,
              payerEmail: MockInvoiceGeneration.payerEmail,
              payerPhone: MockInvoiceGeneration.payerPhone,
              description: MockInvoiceGeneration.description,
              customFields: MockInvoiceGeneration.customFields);
      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.rrr?.length == 12, true);
      expect(remitaChargeResponse.status, 'Payment Reference generated');
      rrr = remitaChargeResponse.rrr!;
    });

    test('Generate RRR with Split Payments', () async {
      RemitaChargeResponse remitaChargeResponse =
          await remitaInvoiceGeneration.generateRRR(
              serviceID: MockInvoiceGeneration.serviceId,
              amount: MockInvoiceGeneration.amount,
              orderID: getRandomString(9),
              payerName: MockInvoiceGeneration.payerName,
              payerEmail: MockInvoiceGeneration.payerEmail,
              payerPhone: MockInvoiceGeneration.payerPhone,
              description: MockInvoiceGeneration.description,
              lineItems: MockInvoiceGeneration.beneficiaryFields);

      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.rrr?.length == 12, true);
      expect(remitaChargeResponse.status, 'Payment Reference generated');
      rrr = remitaChargeResponse.rrr!;
    });

    test('Generate RRR with Split Payments and Custom Fields', () async {
      orderId = getRandomString(9);
      RemitaChargeResponse remitaChargeResponse =
          await remitaInvoiceGeneration.generateRRR(
              serviceID: MockInvoiceGeneration.serviceId,
              amount: MockInvoiceGeneration.amount,
              orderID: orderId,
              payerName: MockInvoiceGeneration.payerName,
              payerEmail: MockInvoiceGeneration.payerEmail,
              payerPhone: MockInvoiceGeneration.payerPhone,
              description: MockInvoiceGeneration.description,
              customFields: MockInvoiceGeneration.customFields,
              lineItems: MockInvoiceGeneration.beneficiaryFields);
      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.rrr?.length == 12, true);
      expect(remitaChargeResponse.status, 'Payment Reference generated');
      rrr = remitaChargeResponse.rrr!;
    });

    test('Check RRR Transaction Status Using RRR', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaInvoiceGeneration.checkTransactionStatus(rrr: rrr);

      expect(remitaStatusResponse.status, '021');
      expect(remitaStatusResponse.message, 'Transaction Pending');
      expect(remitaStatusResponse.transactionTime!.year, DateTime.now().year);
      expect(remitaStatusResponse.rrr, rrr);
    });
  });
}
