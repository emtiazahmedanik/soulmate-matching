import 'package:elias_creed/core/const/image_path.dart' show ImagePath;
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/signup/register/controller/register_controller.dart';
import 'package:elias_creed/feature/auth/signup/widget/pinput_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
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
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify OTP",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Please enter 6 digit OTP sent to your number",
                style: globalTextStyle(
                  color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 40),
              Center(child: OtpInputField(controller: controller)),
              SizedBox(height: 40),
              CustomButton(
                title: "Submit",
                ontap: () async {
                  await controller.verifyOTP();

                  
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
