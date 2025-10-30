import 'package:elias_creed/core/const/icons_path.dart';
import 'package:elias_creed/core/const/image_path.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/auth_service/google_sign_in_service.dart';
import 'package:elias_creed/feature/onboarding/controller/onboarding_controller.dart';
import 'package:elias_creed/feature/onboarding/widget/sign_in_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashScreenImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IconsPath.appIcon, height: 110, width: 111),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "it starts with A Swipe",
                  textAlign: TextAlign.center,
                  style: globalTextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 100),
              SizedBox(height: 13),
              SignInMethod(
                icon: IconsPath.googleIcon,
                text: "Sign in with google",
                ontap: () async {
                  final GoogleSignInService googleService =
                      GoogleSignInService();
                  if (googleService.isAuthorized == false) {
                    await googleService.signIn();
                  }
                },
              ),
              SizedBox(height: 13),
              SignInMethod(
                icon: IconsPath.emailIcon,
                text: "Continue with email and password",
                ontap: () {
                  Get.offAllNamed('/loginView');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
