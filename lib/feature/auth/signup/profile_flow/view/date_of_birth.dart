import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/height_and_weight.dart'
    show HeightAndWeight;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DateOfBirth extends StatelessWidget {
  DateOfBirth({super.key});

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
              "Your Date of Birth",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => controller.pickDate(context),
              child: AbsorbPointer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF252525),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Center(
                        child: TextField(
                          controller: controller.dobController,
                          style: globalTextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                            hintText: "Select Date of Birth",
                            hintStyle: globalTextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () {
                if (controller.dobController.text.isEmpty) {
                  EasyLoading.showError('Plese Select Date of Birth');
                  return;
                }
                Get.to(() => HeightAndWeight());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
