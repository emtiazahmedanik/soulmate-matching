import 'package:elias_creed/core/const/image_path.dart';
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/global_widegts/custom_text_field.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

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
                "Welcome Back 👋",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "We happy to see you again! to use your account, you should sign in first.",
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
              CustomTextField(
                prefixIcon: Icon(Icons.lock),
                controller: controller.passwordController,
                hintText: "Enter your password",
                isObscure: true,
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/forgetPassScreen');
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text("Forget Password?"),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                title: "Login",
                ontap: () async{
                  await controller.handleLogin();
                },
                color: Colors.white,
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Don't have an account?",
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
                    Get.offAllNamed('/registerView');
                  },
                  child: Text(
                    "Signup",
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
    );
  }
}
