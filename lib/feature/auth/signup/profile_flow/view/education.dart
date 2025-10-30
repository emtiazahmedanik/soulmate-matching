import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/add_photos.dart'
    show AddPhotos;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Education extends StatelessWidget {
  Education({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
        child: Column(
          children: [
            Text(
              "Education",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF252525),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Center(
                        child: TextField(
                          controller: controller.universityController,
                          style: globalTextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            hintText: 'Enter university',
                            hintStyle: globalTextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => AddPhotos());
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Center(
                    child: Text(
                      'Skip',
                      style: globalTextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              title: "Next",
              ontap: () {
                Get.to(() => AddPhotos());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
