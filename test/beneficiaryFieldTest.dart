import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';

import 'mockApi.dart';

beneficiaryFieldTest() {
  test('Beneficiary Field Test', () {
    List<Map>? beneficiariesMap = Beneficiary.castList(MockData.beneficiaries);
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
  });
}
