import 'package:elias_creed/feature/auth/signup/profile_flow/view/location_permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';

class About extends StatelessWidget {
  About({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: globalTextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Choose up to 3 prompts and tell us about yourself",
                  style: globalTextStyle(
                    color: Color(0xFFCCCCCC).withAlpha(200),
                  ),
                ),
                SizedBox(height: 24),

                // Prompt Selector
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.availablePrompts.map((prompt) {
                    final isSelected = controller.selectedPrompts.contains(
                      prompt,
                    );
                    return GestureDetector(
                      onTap: () => controller.togglePrompt(prompt),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          prompt,
                          style: globalTextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // Selected Prompt TextFields
                ...controller.selectedPrompts.map((prompt) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prompt,
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: controller.promptAnswers[prompt],
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        style: globalTextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Your answer...",
                          hintStyle: globalTextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
                const SizedBox(height: 150),
                CustomButton(
                  title: "Next",
                  ontap: () {
                    if (controller.selectedPrompts.isEmpty) {
                      EasyLoading.showError('Please Select Prompt');
                      return;
                    }
                    // Optional: Validate input here
                    Get.to(() => LocationPermission());
                  },
                  color: Colors.white,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
