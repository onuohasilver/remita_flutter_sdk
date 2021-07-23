import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/remitaFundTransfer.dart';
import 'package:remita_flutter_sdk/responseObjects/fundTransferResponse.dart';

import 'mockFundTransfer.dart';

fundTransferTest() {
  group('Fund Transfer Test', () {
    RemitaFundTransfer remitaFundTransfer = RemitaFundTransfer(
      apiToken: MockFundTransfer.apiToken,
      merchantID: MockFundTransfer.merchantId,
      apiKey: MockFundTransfer.apiKey,
      encodeIv: MockFundTransfer.iv,
      encodeKey: MockFundTransfer.key,
    );

    //TODO: Get test details
    test('Single Transfer', () async {
      // FundTransferResponse fundTransferResponse =
      //     remitaFundTransfer.singleTransfer(
      //         beneficiaryBankCode: beneficiaryBankCode,
      //         creditAccount: creditAccount,
      //         debitAccount: debitAccount,
      //         narration: narration,
      //         amount: amount,
      //         transRef: transRef,
      //         requestId: requestId,
      //         senderBankCode: senderBankCode);
    });
  });
}
