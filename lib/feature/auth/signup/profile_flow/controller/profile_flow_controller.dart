import 'dart:io';
import 'package:elias_creed/core/internet_connectivity_check/internet_connectivity_checker.dart';
import 'package:elias_creed/core/services_class/firebase_service/file_upload_service/image_upload_service.dart';
import 'package:elias_creed/core/services_class/firebase_service/firestore_service/firestore_service.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/service/location_service.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileFlowController extends GetxController {
  LocationService locationService = LocationService();
  ImageUploadService imageUploadService = ImageUploadService();

  Map<String, dynamic> postUserData = {};

  var nameController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  var aboutController = TextEditingController();

  final List<String> ethnicityList = [
    'Asian',
    'Black / African Descent',
    'Latino / Hispanic',
    'Middle Eastern',
    'Native American / Indigenous',
    'Pacific Islander',
    'South Asian',
    'Southeast Asian',
    'White / Caucasian',
    'Mixed / Multi-Ethnic',
    'Other',
    'Prefer not to say',
  ];

  final selectedEthnicity = ''.obs;

  final selectedGender = 'Male'.obs;
  final selectedSubscription = ''.obs;
  var locationEnabled = false.obs;
  Position? position;

  final TextEditingController dobController = TextEditingController();

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );
    if (picked != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  final TextEditingController textController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final isLoading = false.obs;
  final isDropdownOpen = false.obs;

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  final ImagePicker _picker = ImagePicker();
  final images = List<Rx<File?>>.generate(5, (_) => Rx<File?>(null));

  Future<void> pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images[index].value = File(pickedFile.path);
    }
  }

  final plans = [
    {
      "plan_name": "Basic",
      "price": 0,
      "access_list": [
        "Create and Edit Profile",
        "Swipe Match",
        "Limited Daily Swipes",
      ],
    },
    {
      "plan_name": "Premium",
      "price": 9.99,
      "access_list": [
        "All Free Membership Features",
        "Daily 10 Favor",
        "Unlimited Daily Swipes",
        "Able to directly send date ideas before matching",
      ],
    },
  ].obs;

  // submit to firebase
  Future<void> submit(double price) async {
    await SharedPreferencesHelper.saveRegistrationCompleteFlag();
    await allDataTogether();
    final isSuccess = await postDataFirestore();
    if(isSuccess){
      Get.offAllNamed(AppRoute.bottomNavbarScreen);
    }
  }

  Future<void> allDataTogether() async {
    String? uid = await SharedPreferencesHelper.getUserUid();
    String? email = await SharedPreferencesHelper.getUserEmail();
    String? phone = await SharedPreferencesHelper.getUserPhone();
    final answersMap = promptAnswers.map(
      (key, value) => MapEntry(key, value.text),
    );

    postUserData = {
      'uid': uid ?? '',
      'name': nameController.text.trim(),
      'email': email ?? '',
      'phoneNumber': phone ?? '',
      'ethnicity': selectedEthnicity.value,
      'gender': selectedGender.value,
      'dateOfBirth': dobController.text,
      'heightCm': heightController.text,
      'university': universityController.text,
      'photos': uploadedImageUrlList,
      'about': answersMap,
      'location': {
        'lat': position?.latitude ?? '',
        'long': position?.longitude ?? '',
      },
      'about_me': generateAboutParagraph(answersMap),
      'social_media': {},
      'subscriptionPlan': selectedSubscription.value,
    };
    debugPrint("Final about data: $postUserData");
  }

  final availablePrompts = [
    "A fun fact about me",
    "The most spontaneous thing I've done",
    "I'm known for…",
    "One thing I can't live without",
  ];

  final selectedPrompts = <String>[].obs;
  final promptAnswers = <String, TextEditingController>{}.obs;

  void togglePrompt(String prompt) {
    if (selectedPrompts.contains(prompt)) {
      selectedPrompts.remove(prompt);
      promptAnswers.remove(prompt);
    } else {
      if (selectedPrompts.length < 3) {
        selectedPrompts.add(prompt);
        promptAnswers[prompt] = TextEditingController();
      }
    }
  }

  void getUserLocation() async {
    await locationService.determinePosition();
    position = locationService.position;
    debugPrint("position:${position?.latitude}${position?.longitude}");
  }

  //upload image in firebase

  List<String> uploadedImageUrlList = [];


  //upload image in firebase
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

  // upload data to firestore database
  Future<bool> postDataFirestore() async {
    if (await InternetConnectivityChecker.checkUserConnection() == false) {
      return false;
    }
    try {
      await FirestoreService.saveUserDataToFirestore(postUserData);
      return true;
    } catch (e) {
      debugPrint('database error $e');
      return false;
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
}
