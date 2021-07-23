import 'package:flutter_test/flutter_test.dart';
import 'package:remita_flutter_sdk/generic/hashGenerator.dart';

aesEncryptionTest() {
  test('AES Encryption Test', () {
    String encryption = Encryption(
      encodeKey: 'abcd1234abcd1234',
      encodeIv: '1234abcd1234abcd',
    ).aesEncrypt(
      plainText: 'GoldFish',
    );
    expect(encryption, 'ecNjMcZ7Csy7VE9wTPcZ+w==');
  });
}
