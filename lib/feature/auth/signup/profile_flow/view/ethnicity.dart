import 'package:elias_creed/core/global_widegts/custom_button.dart'
    show CustomButton;
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/select_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Ethnicity extends StatelessWidget {
  Ethnicity({super.key});

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
              "Ethnicity",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Please enter your ethnicity to start your journey with us!",
              style: globalTextStyle(
                color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF252525),
                      isExpanded: true,
                      value: controller.selectedEthnicity.value.isEmpty
                          ? null
                          : controller.selectedEthnicity.value,
                      hint: Text(
                        'Select Ethnicity',
                        style: globalTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      style: globalTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      items: controller.ethnicityList.map((ethnicity) {
                        return DropdownMenuItem<String>(
                          value: ethnicity,
                          child: Text(ethnicity),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedEthnicity.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () {
                  if (controller.selectedEthnicity.value.isEmpty) {
                  EasyLoading.showError('Plese Select Ethnicity');
                  return;
                }
                Get.to(() => SelectGender());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
