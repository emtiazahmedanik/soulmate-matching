import 'package:elias_creed/core/const/image_path.dart' show ImagePath;
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart'
    show OtpTextField;
import 'package:get/get.dart';

class OtpVerifyForgot extends StatelessWidget {
  const OtpVerifyForgot({super.key});

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
                "Please enter 4 digit OTP sent to your email",
                style: globalTextStyle(
                  color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 40),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF979797),
                focusedBorderColor: Colors.white,
                cursorColor: Colors.white,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(8),
                fieldWidth: 50,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.10),
                onSubmit: (otp) {
                  if (kDebugMode) {
                    print("Entered OTP: $otp");
                  }
                },
                textStyle: globalTextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  hintStyle: globalTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 40),
              CustomButton(
                title: "Submit",
                ontap: () {
                  Get.offAllNamed('/newPassScreen');
                  Get.snackbar(
                    "OTP Verified",
                    "You can now create a new password.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green.withValues(alpha: 0.8),
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
