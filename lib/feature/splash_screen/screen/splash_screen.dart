import 'package:elias_creed/core/const/app_colors.dart';
import 'package:elias_creed/core/const/icons_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    final String logo = IconsPath.appIcon;
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Center(child: Image.asset(logo, width: screenWidth * .3)),
    );
  }
}
