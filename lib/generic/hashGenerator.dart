import 'dart:convert';

import 'package:crypto/crypto.dart';

///Combines a parsed list of numbers and
///Calculates the sha 512 hash of the passed input
String returnHash(List<String> rawInput) {
  String rawInputString = '';
  rawInput.forEach((element) {
    rawInputString += element;
  });
  List<int> bytes = utf8.encode(rawInputString); // data being hashed

  Digest digest = sha512.convert(bytes);
  String hashedString = digest.toString();
  return hashedString;
}
