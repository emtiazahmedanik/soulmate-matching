import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:elias_creed/core/style/custom_button_widget.dart';
import 'package:elias_creed/feature/calling/screen/calling_screen.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsSidebar extends StatelessWidget {
  const SettingsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool notificationsEnabled = true.obs;

    return Scaffold(
      backgroundColor: const Color(0xFF040404),
      appBar: AppBar(
        backgroundColor: const Color(0xFF040404),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Switch(
                      value: notificationsEnabled.value,
                      onChanged: (value) => notificationsEnabled.value = value,
                      activeThumbColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.grey,
                      // ignore: deprecated_member_use
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => Get.to(() => CallingScreen()),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Call Center',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            CustomButtonWidget(
              onPressed: () async {
                await SharedPreferencesHelper.clearAllData();
                Get.offAllNamed(AppRoute.onboardingScreen);
              },
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
