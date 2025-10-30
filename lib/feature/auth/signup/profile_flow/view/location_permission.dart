import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPermission extends StatelessWidget {
  LocationPermission({super.key});

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
              "Allow permission for access your location",
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your location helps us personalize your experience and show relevant content",
              textAlign: TextAlign.center,
              style: globalTextStyle(
                color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 40),
            // SwitchTile for location
            Obx(
              () => SwitchListTile(
                title: const Text(
                  "Enable Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  controller.locationEnabled.value
                      ? "Location enabled"
                      : "Turn on to access your location",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                value: controller.locationEnabled.value,
                activeThumbColor: Colors.green,
                onChanged: (value) {
                  if (value == false) return;
                  controller.locationEnabled.value = value;
                  controller.getUserLocation();
                },
              ),
            ),
            Spacer(),
            CustomButton(
              title: "Next",
              ontap: () {
                if (controller.locationEnabled.value == false) return;
                Get.to(() => TermsAndCondition());
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
