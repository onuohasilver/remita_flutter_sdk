import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';

import 'mockApi.dart';

customFieldTest() {
  List<Map>? customFieldMap = CustomField.castList(MockData.customFields);
  dynamic emptyCustomFieldmap = CustomField.castList(null);
  expect(customFieldMap, [
    {"name": "Payer TIN", "value": "1234567890", "type": "ALL"},
    {"name": "Contract Date", "value": "2018/06/27", "type": "ALL"},
  ]);
  expect(emptyCustomFieldmap, null);
}
