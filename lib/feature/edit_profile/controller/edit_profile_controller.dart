import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/core/services_class/firebase_service/file_upload_service/image_upload_service.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/feature/profile/controller/profile_controller.dart';
import 'package:elias_creed/feature/profile/model/profile_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    initializeField();
    super.onInit();
  }

  final UserProfile? userProfileArgs = Get.arguments;

  ImageUploadService imageUploadService = ImageUploadService();

  // Images: 5 slots, can be null or URL
  final images = List<Rx<File?>>.generate(5, (_) => Rx<File?>(null));

  Map<String, dynamic>? postUserData;

  // Form fields
  final nameController = TextEditingController(text: 'Monica');
  final nationality = 'American'.obs;
  String gender = ''; // Fixed
  final dobController = TextEditingController(text: '02/12/2001');
  final heightController = TextEditingController(text: '173');
  final weightController = TextEditingController(text: '48');
  final educationController = TextEditingController(
    text: 'University of Arts and Design',
  );
  final aboutMeController = TextEditingController(
    text:
        "Living life one pose at a time. As a model, I've learned to embrace beauty in all its forms. When I'm not on the runway, I'm exploring new places and creating art with my own unique style.",
  );

  // Social links
  RxMap<String, String> socialLinks = RxMap({
    'facebook': '',
    'instagram': '',
    'tiktok': '',
    'twitter': '',
    'linkedin': '',
  });

  // Nationality options
  final List<String> nationalityOptions = [
    'American',
    'Canadian',
    'British',
    'Australian',
    'Other',
    ''
  ];

  // Date picker logic can be handled in the view

  void allUpdatedData() {
    postUserData = {
      'name': nameController.text.trim(),
      'dateOfBirth': dobController.text,
      'heightCm': heightController.text,
      'weightKg': weightController.text,
      'university': educationController.text,
      'about_me': aboutMeController.text,
      'social_media': socialLinks,
      'nationality': nationality.value,
    };
    if (uploadedImageUrlList.isNotEmpty) {
      postUserData!.addAll({'photos': uploadedImageUrlList});
    }
    debugPrint("Final update profile data: $postUserData");
  }

  //upload image in firebase

  List<String> uploadedImageUrlList = [];

  Future<void> uploadInFirebaseStorage() async {
    final String? userUid = await SharedPreferencesHelper.getUserUid();
    try {
      if (userUid == null) return;
      EasyLoading.show();
      for (int i = 0; i < images.length; i++) {
        if (images[i].value != null) {
          final String imagePath = images[i].value!.path;
          final downloadUrl = await imageUploadService.uploadToFirebase(
            imagePath: imagePath,
            uid: userUid,
          );
          if (downloadUrl != null) {
            uploadedImageUrlList.add(downloadUrl);
          }
        }
      }
      EasyLoading.dismiss();
      debugPrint('upload image url list: $uploadedImageUrlList');
    } catch (e) {
      debugPrint("image upload error : $e");
    }
  }

  //update in firebase

  Future<bool> updateUserProfile(Map<String, dynamic> updatedData) async {
    final uid = await SharedPreferencesHelper.getUserUid();
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      if (uid == null) throw Exception("User not logged in");

      await userRef.update(updatedData);

      debugPrint("Profile updated successfully!");
      return true;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    }
  }

  //ontap save change
  Future<void> onTapSaveChange() async {
    try {
      await uploadInFirebaseStorage();
      allUpdatedData();
      await updateUserProfile(postUserData ?? {});
      Get.back(result: true);
    } catch (e) {
      debugPrint("update profile error : $e");
    }
  }

  void initializeField() {
    nameController.text = userProfileArgs?.name ?? '';
    nationality.value = userProfileArgs?.nationality ?? '';
    gender = userProfileArgs?.gender ?? '';
    dobController.text = userProfileArgs?.dateOfBirth ?? '';
    heightController.text = userProfileArgs?.heightCm ?? '';
    weightController.text = userProfileArgs?.weightKg ?? '';
    educationController.text = userProfileArgs?.university ?? '';
    aboutMeController.text = userProfileArgs?.aboutMe ?? '';
    final socialLink = profileController.userProfile.value!.socialMedia;
    socialLinks['facebook'] = socialLink['facebook'] ?? '';
    socialLinks['twitter'] = socialLink['twitter'] ?? '';
    socialLinks['tiktok'] = socialLink['tiktok'] ?? '';
    socialLinks['instagram'] = socialLink['instagram'] ?? '';
    socialLinks['linkedin'] = socialLink['linkedin'] ?? '';
  }
}
