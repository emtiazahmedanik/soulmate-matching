import 'dart:async';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    String? uid = await SharedPreferencesHelper.getUserUid();
    bool? registrationComplete =
        await SharedPreferencesHelper.checkRegistrationCompleteFlag();
    debugPrint('uid is : $uid');
    Timer(const Duration(seconds: 2), () async {
      if (uid != null) {
        if (registrationComplete != null && registrationComplete == false) {
          Get.offAllNamed(AppRoute.nameScreen);
        } else {
          Get.offAllNamed(AppRoute.bottomNavbarScreen);
        }
      } else {
        Get.offAllNamed(AppRoute.onboardingScreen);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
