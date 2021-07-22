import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/dateConverter.dart';

dateConverterTest() {
  test('Date Converter Test', () async {
    String rawFirstDate = "2019-04-08 10:16:00";
    String rawSecondDate = "08/04/2020";
    DateTime firstDate = convertDate(rawFirstDate);
    DateTime secondDate = convertDate(rawSecondDate);
    expect([firstDate.month, firstDate.year, firstDate.day], [04, 2019, 08]);
    expect([secondDate.month, secondDate.year, secondDate.day], [04, 2020, 08]);
    expect(DateTime.now().isAfter(firstDate), true);
  });
}
