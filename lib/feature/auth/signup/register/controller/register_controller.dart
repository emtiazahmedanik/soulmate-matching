import 'package:elias_creed/core/internet_connectivity_check/internet_connectivity_checker.dart';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/core/utils/validators/validation.dart';
import 'package:elias_creed/feature/auth/auth_service/authentication_service.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  //otp verification
  var phoneNumber = "".obs;
  var otpCode = ''.obs;
  var verificationId = ''.obs;
  var isCodeSent = false.obs;

  final authService = Get.put(AuthenticationService());
  UserCredential? userCredential;

  bool isEmailReggisterSuccess = false;

  bool isValidated = false;

  Future<void> validateFields() async {
    String? message;

    message = FieldValidator.validateEmail(emailController.text);
    if (message != null) return EasyLoading.showError(message);

    message = FieldValidator.validatePassword(passwordController.text);
    if (message != null) return EasyLoading.showError(message);

    if (passwordController.text != confirmPasswordController.text) {
      return EasyLoading.showError('Password does not match');
    }

    message = FieldValidator.validatePhoneNumber(phoneController.text);
    if (message != null) return EasyLoading.showError(message);

    isValidated = true;
  }

  Future<bool> registerUserWithEmail() async {
    try {
      //save email, phone to local
      await SharedPreferencesHelper.saveUserEmailandPhone(
        emailController.text,
        phoneNumber.value,
      );
      //start loading
      EasyLoading.show(status: 'processing');

      //check internet connectivity
      bool isConnected =
          await InternetConnectivityChecker.checkUserConnection();
      if (isConnected == false) {
        EasyLoading.dismiss();
        return false;
      }

      //register user
      userCredential = await authService.registerUserWithEmail(
        emailController.text.trim(),
        passwordController.text,
      );
      if (userCredential?.user != null) {
        await SharedPreferencesHelper.saveUserUid(userCredential!.user!.uid);
        isEmailReggisterSuccess = true;
        return true;
      }
      return false;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// Send OTP
  Future<void> sendOTP() async {
    final cleanNumber = phoneNumber.value.trim().replaceAll(' ', '');
    await validateFields();
    if (isValidated == false) return;
    try {
      //register with email first then link phone
      final isSuccess = await registerUserWithEmail();
      if (isSuccess == false) return;

      debugPrint(cleanNumber);
      await authService.sendOTP(
        phoneNumber: cleanNumber,
        onCodeSent: (verId) {
          verificationId.value = verId;
          isCodeSent.value = true;
          Get.toNamed(AppRoute.verifyOtpScreen);
          EasyLoading.showInfo('Otp sent to your phone');
        },
        onError: (error) {
          debugPrint("otp sent error $error");
          EasyLoading.showError(error.toString());
        },
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// Verify entered OTP
  Future<void> verifyOTP() async {
    try {
      if (otpCode.value.isEmpty) {
        EasyLoading.showError('Please enter OTP');
        return;
      }

      EasyLoading.show(status: 'Verifying OTP');

      await authService.verifyOTP(
        verificationId: verificationId.value,
        smsCode: otpCode.value,
        onSuccess: () {
          if (isEmailReggisterSuccess) {
            Get.toNamed(AppRoute.nameScreen);
          }
        },
        onError: (error) {
          debugPrint("otp verification error $error");
          EasyLoading.showError(error.toString());
        },
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Future<void> storeInFirestore() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userCredential!.user!.uid)
  //       .set({
  //         'email': emailController.text,
  //         'phone': phoneController.text,
  //         'verified': true,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });
  // }
}
