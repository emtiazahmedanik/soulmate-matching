import 'dart:io';

import 'package:elias_creed/core/internet_connectivity_check/internet_connectivity_checker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChatImageUploadService {
  static Future<String?> uploadToFirebase({
    required String imagePath,
    required String uid,
  }) async {
    try {
      debugPrint('uid is : $uid');

      if (await InternetConnectivityChecker.checkUserConnection() == false) {
        EasyLoading.showError('No internet connection');
        return null;
      }

      final ref = FirebaseStorage.instance.ref().child(
        'chats/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      await ref.putFile(File(imagePath));
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }
}
