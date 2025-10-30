import 'dart:io';
import 'package:get/get.dart';

class InternetConnectivityChecker {
  static Future<bool> checkUserConnection() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      Get.snackbar('', 'No internet connection');
    }
    return isConnected;
  }
}
