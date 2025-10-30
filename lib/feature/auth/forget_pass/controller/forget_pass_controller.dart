import 'package:elias_creed/core/utils/validators/validation.dart';
import 'package:elias_creed/feature/auth/auth_service/authentication_service.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController {
  final AuthenticationService authService = Get.put(AuthenticationService());

  bool validated = false;

  var email = ''.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  Future<void> sendLinkToEmail() async {
    await validateFields();
    if (!validated) return;
    await authService.sendPasswordResetEmail(emailController.text.trim());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // user logged in or re-authenticated
        Get.offAllNamed(AppRoute.loginView);
      } else {
        Get.offAllNamed(AppRoute.onboardingScreen);
      }
    });
  }

  void setEmail(String value) {
    email.value = value;
  }

  void resetPassword() {}

  Future<void> validateFields() async {
    String? message;

    message = FieldValidator.validateEmail(emailController.text);
    if (message != null) return EasyLoading.showError(message);

    validated = true;
  }
}
