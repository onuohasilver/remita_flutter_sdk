import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';

import 'mockApi.dart';

createRRR() async {
  RemitaChargeResponse remitaChargeResponse =
      await Mock.generateRRR(MockData.rrrData);
  expect(remitaChargeResponse.rrr, '250008102864');
  expect(remitaChargeResponse.statusCode, '025');
  expect(remitaChargeResponse.status, "Payment Reference generated");
  expect(remitaChargeResponse.statusMessage, null);
}
