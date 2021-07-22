import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/dateConverter.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/beneficiary.dart';
import 'package:remita_flutter_sdk/generic/genericTypes/customFields.dart';
import 'package:remita_flutter_sdk/responseObjects/chargeObject.dart';

import 'beneficiaryFieldTest.dart';
import 'customFieldTest.dart';
import 'dateConverterTest.dart';
import 'directDebitTest.dart';
import 'invoiceGenerationTest.dart';
import 'mockApi.dart';

void main() {
  group('Remita Flutter SDK Tests', () {
    createTestRRR();
    customFieldTest();
    dateConverterTest();
    beneficiaryFieldTest();
    sequenceADirectDebit();
  });
}
