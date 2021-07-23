import 'package:flutter_test/flutter_test.dart';
import 'aesEncryptionTest.dart';
import 'beneficiaryFieldTest.dart';
import 'customFieldTest.dart';
import 'dateConverterTest.dart';
import 'directDebitTest.dart';
import 'invoiceGenerationTest.dart';

void main() {
  group('Remita Flutter SDK Tests', () {
    // customFieldTest();
    // dateConverterTest();
    // beneficiaryFieldTest();
    // aesEncryptionTest();
    invoiceGenerationTest();
    // sequenceADirectDebit();
  });
}
