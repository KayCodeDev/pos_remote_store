import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String encryptData(String data, String secretKey) {
    final keyBytes = utf8.encode(secretKey);
    final iv = Uint8List.fromList(List<int>.generate(16, (index) => 0));
    final cipher = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(keyBytes), iv));

    final encryptedBytes = cipher.process(utf8.encode(data));
    final encryptedData = base64.encode(encryptedBytes);
    final ivBase64 = base64.encode(iv);
    return '$ivBase64:$encryptedData';
  }

  static String decryptData(String encrypted, String secretKey) {
    final parts = encrypted.split(':');
    final iv = base64.decode(parts[0]);
    final encryptedData = base64.decode(parts[1]);

    final keyBytes = utf8.encode(secretKey);
    final cipher = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(keyBytes), iv));

    final decryptedBytes = cipher.process(encryptedData);
    return utf8.decode(decryptedBytes);
  }

  static String formatDateTime(DateTime dt) {
    final now = DateTime.now();
    var diff = now.difference(dt);

    if (diff.inHours < 1) {
      return timeago.format(dt);
    }

    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
