import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/global_widegts/custom_text_field.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/education.dart'
    show Education;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HeightAndWeight extends StatelessWidget {
  HeightAndWeight({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

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
              "Please enter your Height",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 40),
            CustomTextField(
              controller: controller.heightController,
              hintText: "Write your height in Cm",
              isNumber: true,
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () {
                if (controller.heightController.text.isEmpty) {
                  EasyLoading.showError('Plese Enter Your Height');
                  return;
                }
                Get.to(() => Education());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
