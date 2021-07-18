import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';

import 'mockApi.dart';

void main() {
  group('description', () {
    test('Creates a Remita RRR', () async {
      RemitaChargeResponse remitaChargeResponse =
          await Mock.generateRRR(MockData.rrrData);
      expect(remitaChargeResponse.rrr, '250008102864');
      expect(remitaChargeResponse.statusCode, '025');
      expect(remitaChargeResponse.status, "Payment Reference generated");
      expect(remitaChargeResponse.statusMessage, null);
    });
    test('Maps A list of customField objects to a map', () {
      List<Map>? customFieldMap = CustomField.castList(MockData.customFields);
      dynamic emptyCustomFieldmap = CustomField.castList(null);
      expect(customFieldMap, [
        {"name": "Payer TIN", "value": "1234567890", "type": "ALL"},
        {"name": "Contract Date", "value": "2018/06/27", "type": "ALL"},
      ]);
      expect(emptyCustomFieldmap, null);
    });

    test(
      'Maps a list of beneficiary objects to a map',
      () {
        List<Map>? beneficiariesMap =
            Beneficiary.castList(MockData.beneficiaries);
        List<Map>? emptyBeneficiariesMap = Beneficiary.castList(null);
        expect(beneficiariesMap, [
          {
            "lineItemsId": "itemid1",
            "beneficiaryName": "Alozie Michael",
            "beneficiaryAccount": "6020067886",
            "bankCode": "058",
            "beneficiaryAmount": "7000",
            "deductFeeFrom": "1"
          }
        ]);
        expect(emptyBeneficiariesMap, null);
      },
    );
  });
}
