import 'package:elias_creed/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:elias_creed/core/utils/exceptions/firebase_exceptions.dart';
import 'package:elias_creed/core/utils/exceptions/format_exceptions.dart';
import 'package:elias_creed/core/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthenticationService extends GetxController {
  final _auth = FirebaseAuth.instance;
  UserCredential? userAuthCredential;

  Future<UserCredential> registerUserWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userAuthCredential = userCredential;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  /// Send OTP to given phone number
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  /// Verify OTP and sign in
  Future<void> verifyOTP({
    required String verificationId,
    required String smsCode,
    required Function() onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Step 3: Link phone to same account
      if (userAuthCredential != null) {
        await userAuthCredential!.user!.linkWithCredential(credential);
      }
      onSuccess();
    } catch (e) {
      onError('Invalid OTP');
    }
  }

  //login user with email and password

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {

      // Try signing in
      userAuthCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }


  //send reset password to email


Future<void> sendPasswordResetEmail(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email.trim());
    EasyLoading.showSuccess('Password reset email sent to $email');
  } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
}

}
