import 'package:elias_creed/core/const/image_path.dart';
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/global_widegts/custom_text_field.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/forget_pass/controller/forget_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({super.key});

  final ForgetPassController controller = Get.put(ForgetPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                "Forgot Password? 👋",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 20),
              CustomTextField(
                prefixIcon: Icon(Icons.email),
                controller: controller.emailController,
                hintText: "Enter your email",
                isObscure: false,
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Send Reset Link",
                ontap: () {
                  controller.sendLinkToEmail();
                  // Get.to(() => OtpVerifyForgot());
                },
                color: Colors.white,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
