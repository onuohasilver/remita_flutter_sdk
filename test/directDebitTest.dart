import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/remitaDirectDebit.dart';
import 'package:remita_flutter_sdk/responseObjects/statusObject.dart';

import 'mockRemitaData.dart';

sequenceADirectDebit() {
  RemitaDirectDebit remitaDirectDebit = RemitaDirectDebit(
      merchantID: MockDirectDebit.merchantId, apiKey: MockDirectDebit.apiKey);

  group('Sequence A Direct Debit', () {
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
      expect(remitaStatusResponse.statusCode, "040");
      expect(remitaStatusResponse.status, "Initail Request OK");
    });
  });
}
