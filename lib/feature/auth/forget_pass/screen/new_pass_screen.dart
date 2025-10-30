import 'package:elias_creed/core/const/image_path.dart' show ImagePath;
import 'package:elias_creed/core/global_widegts/custom_button.dart'
    show CustomButton;
import 'package:elias_creed/core/global_widegts/custom_text_field.dart'
    show CustomTextField;

import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/forget_pass/controller/forget_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassScreen extends StatelessWidget {
  NewPassScreen({super.key});

  final ForgetPassController controller = Get.put(ForgetPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.authBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create a New Password",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 20),
              CustomTextField(
                prefixIcon: Icon(Icons.lock),
                controller: controller.passwordController,
                hintText: "Enter your password",
                isObscure: true,
              ),
              SizedBox(height: 20),
              CustomTextField(
                prefixIcon: Icon(Icons.lock),
                controller: controller.confirmPasswordController,
                hintText: "Confirm your password",
                isObscure: true,
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Change Password",
                ontap: () {
                  Get.offAllNamed('loginView');
                  controller.resetPassword();
                  Get.snackbar(
                    "Password Reset",
                    "Your password has been successfully reset.",
                    snackPosition: SnackPosition.TOP,
                    // ignore: deprecated_member_use
                    backgroundColor: Colors.green.withOpacity(0.8),
                    colorText: Colors.white,
                  );
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
