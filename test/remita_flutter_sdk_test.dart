import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';

import 'beneficiaryFieldTest.dart';
import 'customFieldTest.dart';
import 'dateConverterTest.dart';
import 'invoiceGenerationTest.dart';
import 'mockApi.dart';

void main() {
  group('description', () {
    test('Creates a Remita RRR', createRRR());
    test('Maps A list of customField objects to a map', customFieldTest());
    test('Maps a list of beneficiary objects to a map', beneficiaryFieldTest());
    test('Date Converter test', dateConverterTest());
  });
}
