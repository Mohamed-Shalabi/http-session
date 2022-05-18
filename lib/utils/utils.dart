import 'dart:async';

import 'dart:io';

class Utils {
  Utils._();

  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
