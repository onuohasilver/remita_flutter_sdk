import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/remitaDirectDebit.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateHistoryObject.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateStatus.dart';
import 'package:remita_flutter_sdk/responseObjects/statusObject.dart';

import 'mockRemitaData.dart';

sequenceADirectDebit() {
  RemitaDirectDebit remitaDirectDebit = RemitaDirectDebit(
      merchantID: MockDirectDebit.merchantId, apiKey: MockDirectDebit.apiKey);

  group('Sequence A Direct Debit', () {
    late String mandateId, requestId;

    test('Generate A Mandate', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.generateMandate(
              serviceID: MockDirectDebit.serviceTypeId,
              requestId: MockDirectDebit.requestId,
              amount: MockDirectDebit.amount,
              payerName: MockDirectDebit.payerName,
              payerEmail: MockDirectDebit.payerEmail,
              payerPhone: MockDirectDebit.payerPhone,
              payerBankCode: MockDirectDebit.payerBankCode,
              payerAccount: MockDirectDebit.payerAccount,
              startDate: MockDirectDebit.startDate,
              endDate: MockDirectDebit.endDate,
              mandateType: MockDirectDebit.mandateType,
              maxNoOfDebits: MockDirectDebit.maxNoOfDebits);
      expect(remitaStatusResponse.statuscode, "040");
      expect(remitaStatusResponse.status, "Initail Request OK");
      requestId = remitaStatusResponse.requestId!;
      mandateId = remitaStatusResponse.mandateId!;
    });

    test('Request OTP test', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.mandateOTPrequest(
              apiToken: MockDirectDebit.apiToken,
              requestId: requestId,
              mandateId: mandateId);

      expect(remitaStatusResponse.statuscode, "00");
      expect(remitaStatusResponse.status, "SUCCESS");
      expect(
          remitaStatusResponse.authParams![0]['label1'], 'One Time Password');
      // expect(remitaStatusResponse.authParams, matcher)
    });

    test('Validate OTP test', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.mandateOTPactivate(
              requestId: requestId,
              remitaTransferRef: MockDirectDebit.remitaTransRef,
              otp: MockDirectDebit.otp,
              card: MockDirectDebit.card,
              apiToken: MockDirectDebit.apiToken);

      expect(remitaStatusResponse.statuscode, '075');
      expect(remitaStatusResponse.status, 'Mandate is Already Active');
    });

    test('Print Mandate', () async {
      Uri printUri = await remitaDirectDebit.printMandate(
          requestId: requestId, mandateId: mandateId);
      expect(
          printUri.data!
              .contentAsString()
              .contains('Loading Payment Mandate Form'),
          true);
    });

    test('Check Mandate Status', () async {
      RemitaMandateStatus remitaStatusResponse = await remitaDirectDebit
          .checkMandateStatus(requestId: requestId, mandateId: mandateId);
      expect(remitaStatusResponse.mandateId, mandateId);
      expect(remitaStatusResponse.isActive, false);
      expect(
          remitaStatusResponse.endDate!
              .isAfter(remitaStatusResponse.startDate!),
          true);
    });
    test('Retrieve Mandate History', () async {
      MandateHistoryObject mandateHistoryObject = await remitaDirectDebit
          .mandatePaymentHistory(mandateId: mandateId, requestId: requestId);
      expect(mandateHistoryObject.statusCode, '074');
      expect(mandateHistoryObject.status, "NO AVAILABLE RECORD");

      ///TODO: Write a test for when the paymentDetails contains data
      expect(mandateHistoryObject.data.paymentDetails!.isEmpty, true);
      expect(mandateHistoryObject.mandateId, mandateId);
    });

    test('Stop Mandate', () async {
      RemitaStatusResponse remitaStatusResponse = await remitaDirectDebit
          .stopMandate(mandateId: mandateId, requestId: requestId);
      expect(remitaStatusResponse.statuscode, '00');
      expect(remitaStatusResponse.requestId, requestId);
      expect(remitaStatusResponse.mandateId, mandateId);
      expect(remitaStatusResponse.status, 'Successful');
    });
  });
}
