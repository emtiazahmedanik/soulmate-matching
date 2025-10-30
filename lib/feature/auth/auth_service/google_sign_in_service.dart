import 'dart:async';
import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // Singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Stream subscription for authentication events
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  GoogleSignInService() {
    _initialize();
  }

  /// Initialize Google Sign-In
  Future<void> _initialize() async {
    await _googleSignIn.initialize(
      clientId: null, // optional for mobile
      serverClientId:
          '863134484823-9k7l193nva0eden4tjqvulg5pom9p88r.apps.googleusercontent.com',
    );

    // Listen for authentication changes
    _authSubscription = _googleSignIn.authenticationEvents.listen(
      _handleAuthEvent,
      onError: _handleAuthError,
    );

    // Try lightweight authentication (auto sign-in)
    await _googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> _handleAuthEvent(GoogleSignInAuthenticationEvent event) async {
    GoogleSignInAccount? user;
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        user = event.user;
        break;
      case GoogleSignInAuthenticationEventSignOut():
        user = null;
        break;
    }

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes([
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ]);

    _currentUser = user;
    _isAuthorized = authorization != null;

    if (_currentUser != null) {
      if (kDebugMode) {
        print(
          "✅ Signed in: ${_currentUser!.displayName} (${_currentUser!.email}) (${_currentUser!.photoUrl} )",
        );
      }
    } else {
      if (kDebugMode) {
        print("🚪 Signed out");
      }
    }
  }

  void _handleAuthError(Object error) {
    if (kDebugMode) {
      print("❌ Google Sign-In error: $error");
    }
    _currentUser = null;
    _isAuthorized = false;
  }

  Future<void> signIn() async {
    try {
      EasyLoading.show();

      final GoogleSignInAccount signin = await _googleSignIn.authenticate();
      final String? idToken = signin.authentication.idToken;

      // Create a credential for Firebase
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // Sign in with Firebase using the credential
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser) {
        if (kDebugMode) {
          print("🆕 New user — need to create Firestore document.");
        }
      } else {
        if (kDebugMode) {
          print("👤 Existing user — fetch user data from Firestore.");
        }
      }

      debugPrint(
        "user credential: ${userCredential.user!.uid} ${userCredential.user!.providerData}",
      );

      //save user uid and email in local storage
      await SharedPreferencesHelper.saveUserUid(userCredential.user!.uid);
      await SharedPreferencesHelper.saveUserEmailandPhone(
        userCredential.user!.email ?? '',
        '',
      );

      EasyLoading.dismiss();

      //Get.offAllNamed(AppRoute.nameScreen);

      if (isNewUser) {
        Get.offAllNamed(AppRoute.nameScreen);
      } else {
        await SharedPreferencesHelper.saveUserUid(userCredential.user!.uid);
        await SharedPreferencesHelper.saveRegistrationCompleteFlag();
        await SharedPreferencesHelper.saveUserEmailandPhone(
          userCredential.user!.email ?? '',
          userCredential.user!.phoneNumber ?? '',
        );
        Get.offAllNamed(AppRoute.bottomNavbarScreen);
      }
    } on GoogleSignInException catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print("⚠️ Sign-in canceled or failed: ${e.code}");
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (kDebugMode) {
        print("❌ Unknown sign-in error: $e");
      }
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    _currentUser = null;
    _isAuthorized = false;
  }

  /// Current signed-in user
  GoogleSignInAccount? get currentUser => _currentUser;

  /// Whether user is authorized for required scopes
  bool get isAuthorized => _isAuthorized;

  /// Dispose the stream subscription
  void dispose() {
    _authSubscription?.cancel();
  }
}
