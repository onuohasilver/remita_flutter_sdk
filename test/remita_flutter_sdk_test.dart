import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/remita.dart';

import 'package:remita_flutter_sdk/remita_flutter_sdk.dart';
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
      dynamic emptyCustomFieldmap = CustomField.castList();
      expect(customFieldMap, [
        {"name": "Payer TIN", "value": "1234567890", "type": "ALL"},
        {"name": "Contract Date", "value": "2018/06/27", "type": "ALL"},
      ]);
      expect(emptyCustomFieldmap, null);
    });
  });
}
