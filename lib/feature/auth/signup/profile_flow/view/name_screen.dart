import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/global_widegts/custom_text_field2.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/ethnicity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});

  final ProfileFlowController controller = Get.put(ProfileFlowController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your name",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Please enter your name start your journey with us!",
              style: globalTextStyle(
                color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 40),
            CustomTextField2(
              prefixIcon: Icon(Icons.person),
              controller: controller.nameController,
              hintText: "Enter your name",
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () {
                if (controller.nameController.text.isEmpty) {
                  EasyLoading.showError('Plese Enter Name');
                  return;
                }

                Get.to(() => Ethnicity());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
