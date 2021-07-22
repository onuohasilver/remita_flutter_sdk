import 'package:remita_flutter_sdk/generic/hashGenerator.dart';
import 'package:remita_flutter_sdk/getRandomString.dart';

class MockRemitaData {
  static String merchantId = "27768931";
  static String apiKey = "Q1dHREVNTzEyMzR8Q1dHREVNTw==";
  static String apiToken =
      "SGlQekNzMEdMbjhlRUZsUzJCWk5saDB6SU14Zk15djR4WmkxaUpDTll6bGIxRCs4UkVvaGhnPT0=";
  static String otp = "1234";
  static String card = "0441234567890";
  static String remitaTransRef = "1587568766736";

  static String requestId = getRandomString(12);
  static List<String> hashableString = [apiKey, requestId, apiToken];
  var apiHash = returnHash(hashableString);
}
