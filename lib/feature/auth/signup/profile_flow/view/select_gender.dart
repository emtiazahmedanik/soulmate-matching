import 'package:elias_creed/core/const/icons_path.dart';
import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/date_of_birth.dart'
    show DateOfBirth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SelectGender extends StatelessWidget {
  SelectGender({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          left: 24,
          right: 24,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your gender",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please select your gender and start your journey with us!",
              style: globalTextStyle(
                color: const Color(0xFFCCCCCC).withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 40),

            /// Male Option
            Obx(() {
              final isSelected = controller.selectedGender.value == 'Male';
              return GestureDetector(
                onTap: () => controller.selectedGender.value = 'Male',
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        isSelected
                            ? IconsPath.selectedMale
                            : IconsPath.unselectedMale,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Male",
                        style: globalTextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            /// Female Option
            Obx(() {
              final isSelected = controller.selectedGender.value == 'Female';
              return GestureDetector(
                onTap: () => controller.selectedGender.value = 'Female',
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        isSelected
                            ? IconsPath.selectedFemale
                            : IconsPath.unselectedFemale,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Female",
                        style: globalTextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            CustomButton(
              title: "Next",
              ontap: () {
                if (kDebugMode) {
                  print("Selected Gender: ${controller.selectedGender.value}");
                }
                if (controller.selectedEthnicity.value.isEmpty) {
                  EasyLoading.showError('Plese Select Gender');
                  return;
                }
                Get.to(() => DateOfBirth());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
