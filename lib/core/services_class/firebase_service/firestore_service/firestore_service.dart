import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirestoreService {
  static Future<void> saveUserDataToFirestore(
    Map<String, dynamic> userData,
  ) async {
    try {
      EasyLoading.show();
      final uid = userData['uid'];

      if (uid == null || uid.isEmpty) {
        EasyLoading.dismiss();
        throw Exception('User UID is missing.');
      }

      // Reference to the "users" collection
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Set the user data (create if not exists, update if exists)
      await userRef.set(userData, SetOptions(merge: true));

      debugPrint("User data successfully saved to Firestore!");
      EasyLoading.dismiss();
    } catch (e) {
      debugPrint("Error saving user data: $e");
      EasyLoading.dismiss();
    }
  }
}
