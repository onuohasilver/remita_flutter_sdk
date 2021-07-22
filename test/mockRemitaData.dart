import 'package:remita_flutter_sdk/generic/hashGenerator.dart';
import 'package:remita_flutter_sdk/getRandomString.dart';

class MockDirectDebit {
  static String merchantId = "27768931";
  static String apiKey = "Q1dHREVNTzEyMzR8Q1dHREVNTw==";
  static String apiToken =
      "SGlQekNzMEdMbjhlRUZsUzJCWk5saDB6SU14Zk15djR4WmkxaUpDTll6bGIxRCs4UkVvaGhnPT0=";
  static String otp = "1234";
  static String card = "0441234567890";

  static String remitaTransRef = "1587568766736";
  static String payerName = 'ADEYEMI JAMES';
  static String payerEmail = 'segunakomolafe5@gmail.com';
  static String payerPhone = '08012345678';
  static String payerBankCode = '057';
  static String serviceTypeId = '35126630';
  static String payerAccount = '1234890001';
  static String amount = '1000.00';
  static String mandateType = 'DD';
  static DateTime endDate = DateTime(2021, 12, 30);
  static DateTime startDate = DateTime(2021, 01, 27);

  static String maxNoOfDebits = '3';

  static String requestId = getRandomString(12);
  static List<String> hashableString = [apiKey, requestId, apiToken];
  var apiHash = returnHash(hashableString);
}
