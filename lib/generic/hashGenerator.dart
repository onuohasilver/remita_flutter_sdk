import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class Encryption {
  final String? encodeKey, encodeIv;
  Encryption({this.encodeKey, this.encodeIv});

  ///Combines a parsed list of numbers and
  ///Calculates the sha 512 hash of the passed input
  static String sha512Encrypt(List<String> rawInput) {
    String rawInputString = '';
    rawInput.forEach((element) {
      rawInputString += element;
    });
    List<int> bytes = utf8.encode(rawInputString); // data being hashed

    Digest digest = sha512.convert(bytes);
    String hashedString = digest.toString();
    return hashedString;
  }

  String aesEncrypt({
    required String plainText,
  }) {
    final key = Key.fromUtf8(encodeKey!);
    final iv = IV.fromUtf8(encodeIv!);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }
}
