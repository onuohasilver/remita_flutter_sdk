import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';

class Mock {
  ///Returns a  Mock of a ChargeObject
  static Future<RemitaChargeResponse> generateRRR(json) {
    return Future.value(RemitaChargeResponse.fromJson(json));
  }
}

class MockData {
  static const Map rrrData = {
    "statuscode": "025",
    "RRR": "250008102864",
    "status": "Payment Reference generated"
  };

  static const List<CustomField> customFields = [
    CustomField(value: '1234567890', name: 'Payer TIN', type: 'ALL'),
    CustomField(value: '2018/06/27', name: 'Contract Date', type: 'ALL'),
    
  ];
}
