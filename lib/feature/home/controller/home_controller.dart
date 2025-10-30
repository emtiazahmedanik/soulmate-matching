import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elias_creed/core/model/global_user_model.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/service/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LocationService locationService = LocationService();
  var userid = ''.obs;

  @override
  void onInit() {
    callMethods();
    super.onInit();
  }

  void callMethods() async {
    userid.value = await SharedPreferencesHelper.getUserUid() ?? '';

    await loadUsers();
    await fetchLocation();
  }

  Future<void> fetchLocation() async {
    await locationService.determinePosition();
    if (locationService.position != null) {
      currentPosition.value = locationService.position!;
    }
    debugPrint(
      'this user location is: ${locationService.position?.latitude} ${locationService.position?.longitude}',
    );
  }

  var currentIndex = 0.obs;

  void updateIndex(int index) {
    if (index < users.length) {
      currentIndex.value = index;
    }
  }

  var users = <GlobalUserModel>[].obs;

  Future<void> loadUsers() async {
    users.value = await fetchAllUsers();
  }

  Future<List<GlobalUserModel>> fetchAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();

      // Convert Firestore documents to UserModel list
      final users = snapshot.docs
          .where((doc) => doc.id != userid.value)
          .map((doc) => GlobalUserModel.fromMap(doc.data()))
          .toList();

      if (kDebugMode) {
        print(" fetching users: ${users.length}");
      }

      return users;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching users: $e");
      }
      return [];
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

  var currentPosition = Rxn<Position>();
}
