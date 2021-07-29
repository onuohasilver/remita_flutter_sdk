import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/getRandomString.dart';
import 'package:remita_flutter_sdk/remitaDirectDebit.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateHistoryObject.dart';
import 'package:remita_flutter_sdk/responseObjects/mandateStatus.dart';
import 'package:remita_flutter_sdk/responseObjects/statusObject.dart';

import 'mockDirectDebit.dart';

sequenceADirectDebit() {
  RemitaDirectDebit remitaDirectDebit = RemitaDirectDebit(
      merchantID: MockDirectDebit.merchantId, apiKey: MockDirectDebit.apiKey);

  group('Sequence A Direct Debit', () {
    late String mandateId, requestId, remitaTransRef;

    test('Generate A Mandate', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.generateMandate(
              serviceID: MockDirectDebit.serviceTypeId,
              amount: MockDirectDebit.amount,
              requestId: MockDirectDebit.requestId,
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

      mandateId = remitaStatusResponse.mandateId!;
      requestId = remitaStatusResponse.requestId!;
    });

    test('Request OTP test', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.mandateOTPrequest(
              requestId: requestId,
              apiToken: MockDirectDebit.apiToken,
              mandateId: mandateId);

      expect(remitaStatusResponse.statuscode, "00");
      expect(remitaStatusResponse.status, "SUCCESS");
      expect(
          remitaStatusResponse.authParams![0]['label1'], 'One Time Password');
      remitaTransRef = remitaStatusResponse.remitaTransRef!;
    });

    test('Validate OTP test', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.mandateOTPactivate(
              remitaTransferRef: remitaTransRef,
              otp: MockDirectDebit.otp,
              card: MockDirectDebit.card,
              apiToken: MockDirectDebit.apiToken);

      expect(remitaStatusResponse.statuscode, '00');
      expect(remitaStatusResponse.status, 'Mandate Activated Successfully');
    });

    test('Print Mandate', () async {
      Uri printUri = await remitaDirectDebit.printMandate(
          mandateId: mandateId, requestId: requestId);
      expect(
          printUri.data!
              .contentAsString()
              .contains('Loading Payment Mandate Form'),
          true);
    });

    test('Check Mandate Status', () async {
      RemitaMandateStatus remitaStatusResponse = await remitaDirectDebit
          .checkMandateStatus(mandateId: mandateId, requestId: requestId);
      expect(remitaStatusResponse.mandateId, mandateId);
      expect(remitaStatusResponse.isActive, true);
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
      print([mandateId, requestId]);
      expect(mandateHistoryObject.data.paymentDetails!.isEmpty, true);
      expect(mandateHistoryObject.mandateId, mandateId);
    });

    test('Send Debit Instruction', () async {
      RemitaStatusResponse remitaStatusResponse =
          await remitaDirectDebit.sendDebitInstruction(
              serviceId: MockDirectDebit.serviceTypeId,
              debitAmount: '300',
              mandateId: mandateId,
              requestId:
                  DateTime(2021, 12, 10).millisecondsSinceEpoch.toString(),
              payerAccount: MockDirectDebit.payerAccount,
              payerBankCode: MockDirectDebit.payerBankCode);
      expect(remitaStatusResponse.statuscode, '062');
      expect(remitaStatusResponse.status, 'Mandate Not Due');
    });

    // // /TODO: Clarify if tests are only passed when the mandate is activated
    // // /FIXME: Test fails with non activated Mandates

    test('Check Debit Instruction Status', () async {
      RemitaStatusResponse remitaStatusResponse = await remitaDirectDebit
          .debitInstructionStatus(mandateId: mandateId, requestId: requestId);

      expect(remitaStatusResponse.statuscode, '072');
      expect(remitaStatusResponse.status, 'Awaiting Credit');
      expect(remitaStatusResponse.transactionRef != null, true);
      remitaTransRef = remitaStatusResponse.transactionRef!.toString();
      print(remitaStatusResponse.toString());
    });

    // test('Cancel Debit Instruction', () async {
    //   RemitaStatusResponse remitaStatusResponse =
    //       await remitaDirectDebit.cancelDebitInstruction(
    //     mandateId: mandateId,
    //     transactionRef: remitaTransRef,
    //     requestId:requestId
    //   );
    //   // print(remitaStatusResponse.toString());

    //   expect(remitaStatusResponse.mandateId, mandateId);
    //   expect(remitaStatusResponse.statuscode, '02');
    // });

    // test('Stop Mandate', () async {
    //   RemitaStatusResponse remitaStatusResponse =
    //       await remitaDirectDebit.stopMandate(mandateId: mandateId);

    //   expect(remitaStatusResponse.statuscode, '00');
    //   expect(remitaStatusResponse.mandateId, mandateId);
    //   expect(remitaStatusResponse.status, 'Successful');
    // });
  });
}
