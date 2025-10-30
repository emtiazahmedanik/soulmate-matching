import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/core/model/global_user_model.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/feature/home/controller/home_controller.dart';
import 'package:elias_creed/feature/profile/controller/profile_controller.dart';
import 'package:elias_creed/feature/profile/model/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MatchesController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  List<GlobalUserModel> matches = [];

  final ProfileController profileController = Get.put(ProfileController());

  RxString gender = ''.obs;
  RxInt userAge = 0.obs;
  RxString userid = ''.obs;
  var userProfile = Rxn<UserProfile>();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    await fetchCurrentUserData();
    await loadMatches();
  }

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
      userAge.value = userProfile.value?.age ?? 0;
    } else {
      EasyLoading.showInfo('First create an account');
      debugPrint('document not found');
    }
  }

  Future<void> loadMatches() async {
    userid.value = await SharedPreferencesHelper.getUserUid() ?? '';

    final interestedIn = getInterestedIn();
    final minAge = userAge.value - 10;
    final maxAge = userAge.value + 10;

    matches = await fetchMatches(
      currentUserGender: gender.value,
      interestedIn: interestedIn,
      minAge: minAge,
      maxAge: maxAge,
    );

    if (kDebugMode) {
      print('Fetched matches: ${matches.length}');
    }
  }

  Future<List<GlobalUserModel>> fetchMatches({
    required String currentUserGender,
    required String interestedIn,
    required int minAge,
    required int maxAge,
  }) async {
    debugPrint('interested in: $interestedIn');
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('gender', isEqualTo: interestedIn)
        .get();

    // Convert Firestore documents to UserModel list
    final users = querySnapshot.docs
        .where((doc) => doc.id != userid.value)
        .map((doc) => GlobalUserModel.fromMap(doc.data()))
        .toList();

    // Convert to list of maps
    return users;
  }

  String getInterestedIn() {
    debugPrint('gender: ${gender.value}');
    if (gender.value == 'Male') {
      return 'Female';
    } else if (gender.value == 'Female') {
      return 'Male';
    } else {
      return 'Other';
    }
  }

  double calculateDistanceKmSync(
    double startLat,
    double startLong,
    double endLat,
    double endLong,
  ) {
    final distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLong,
      endLat,
      endLong,
    );
    return distanceInMeters / 1000; // Convert to km
  }
}
