import 'package:elias_creed/feature/profile/model/profile_model.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    fetchCurrentUserData();
    super.onInit();
  }

  var userProfile = Rxn<UserProfile>();
  RxString gender = ''.obs;

  Future<void> fetchCurrentUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return; // User not logged in

    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (docSnapshot.exists) {
      debugPrint('user profile data: ${docSnapshot.data()}');
      final data = docSnapshot.data()!;
      userProfile.value = UserProfile.fromMap(data);
      gender.value = userProfile.value?.gender ?? '';
    } else {
      EasyLoading.showInfo('First create an account');
      Get.toNamed(AppRoute.nameScreen);
      debugPrint('document not found');
    }
  }

  String generateAboutParagraph(Map<String, dynamic> aboutMap) {
    if (aboutMap.isEmpty) return "";

    List<String> sentences = [];

    aboutMap.forEach((key, value) {
      if (value != null && value.toString().trim().isNotEmpty) {
        sentences.add("$key: ${value.toString().trim()}");
      }
    });

    return "${sentences.join(". ")}."; // Combine into single paragraph
  }

  Future<void> openUrlInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // opens in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
