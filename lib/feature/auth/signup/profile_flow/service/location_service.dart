import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? position;
  Future<void> determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, return early.
        EasyLoading.showError('Location services are not enabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, return error.
          EasyLoading.showError('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever.
        EasyLoading.showError(
          'Location permissions are permanently denied, cannot request.',
        );
      }

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
      );

      position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      debugPrint("Location fetch error: $e");
    }
    
  }
}
