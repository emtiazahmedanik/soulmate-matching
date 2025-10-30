import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/core/utils/validators/validation.dart';
import 'package:elias_creed/feature/auth/auth_service/authentication_service.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final authService = Get.put(AuthenticationService());

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool validated = false;

  Future<void> handleLogin() async {
    try {
      await validateFields();

      if (!validated) return;

      await authService.loginWithEmailPassword(
        emailController.text.trim(),
        passwordController.text,
      );

      if (authService.userAuthCredential != null) {
        final userUid = authService.userAuthCredential!.user!.uid;
        final userEmail = authService.userAuthCredential!.user!.email;
        final userPhone = authService.userAuthCredential!.user!.phoneNumber;

        await SharedPreferencesHelper.saveUserUid(userUid);
        await SharedPreferencesHelper.saveUserEmailandPhone(
          userEmail!,
          userPhone,
        );

        Get.toNamed(AppRoute.bottomNavbarScreen);
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      // Show error message
      if (kDebugMode) {
        print("login error: $e");
      }
    }
  }

  Future<void> validateFields() async {
    String? message;

    message = FieldValidator.validateEmail(emailController.text);
    if (message != null) return EasyLoading.showError(message);

    message = FieldValidator.validatePassword(passwordController.text);
    if (message != null) return EasyLoading.showError(message);

    validated = true;
  }
}
