import 'package:elias_creed/core/const/image_path.dart' show ImagePath;
import 'package:elias_creed/core/global_widegts/custom_button.dart'
    show CustomButton;
import 'package:elias_creed/core/global_widegts/custom_text_field.dart'
    show CustomTextField;

import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/register/controller/register_controller.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final RegisterController controller = Get.put(RegisterController());

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create an Account",
                  style: globalTextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "to continue with Unity",
                  style: globalTextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  prefixIcon: Icon(Icons.email),
                  controller: controller.emailController,
                  hintText: "Enter your email",
                  isObscure: false,
                ),
                SizedBox(height: 20),
                buildPhoneField(
                  controller: controller.phoneController,
                  hintText: 'Enter your phone number',
                  onChanged: (phone) {
                    if (kDebugMode) {
                      print(phone.completeNumber);
                    }
                    controller.phoneNumber.value = phone.completeNumber;
                  },
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
                  title: "Sign up",
                  ontap: () async {
                    //register with email
                    //await controller.registerUserWithEmail();

                    //register with phone number
                    await controller.sendOTP();
                  },
                  color: Colors.white,
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Already have an account?",
                    style: globalTextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(AppRoute.loginView);
                    },
                    child: Text(
                      "Login",
                      style: globalTextStyle(
                        color: Color(0xFFDFB839),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildPhoneField({
  required TextEditingController controller,
  String hintText = 'Phone Number',
  Function(PhoneNumber)? onChanged,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
      border: Border.all(color: const Color(0xFF979797), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: IntlPhoneField(
      controller: controller,
      style: globalTextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        hintText: hintText,
        hintStyle: globalTextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        border: InputBorder.none,
      ),
      dropdownTextStyle: globalTextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      initialCountryCode: 'BD', // Change to your default country
      onChanged: (phone) {
        if (onChanged != null) onChanged(phone);
      },
      keyboardType: TextInputType.phone,
      cursorColor: Colors.white,
      dropdownDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
