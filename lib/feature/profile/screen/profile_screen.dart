import 'package:elias_creed/feature/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:elias_creed/feature/edit_profile/view/edit_profile_view.dart';
import 'package:elias_creed/feature/profile/controller/profile_controller.dart';
import 'package:elias_creed/feature/profile/widget/profile_photo_carousel.dart';
import 'package:elias_creed/feature/profile/widget/settings_sidebar.dart';
import 'package:elias_creed/feature/profile/widget/social_media_icons.dart';
import 'package:elias_creed/feature/subscription/screen/upgrade_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final BottomNavbarController bottomNavbarController = Get.put(
    BottomNavbarController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040404),
      appBar: AppBar(
        backgroundColor: const Color(0xFF040404),
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Get.to(() => UpGradePlan()),
            child: const Text('UPGRADE', style: TextStyle(color: Colors.white)),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Get.to(() => const SettingsSidebar()),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.userProfile.value;
        if (user == null) {
          controller.fetchCurrentUserData(); // fetch when first open
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).copyWith(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Center(child: ProfilePhotoCarousel()),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF252525),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        elevation: 0,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () => bottomNavbarController.changeIndex(1),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Matches',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${user.name} (${user.age})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.female, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        user.gender,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.height, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        user.heightCm,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.school, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          user.university,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFF252525), height: 1),
                  const SizedBox(height: 24),
                  const Text(
                    'About me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.aboutMe,
                    style: const TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Social Media',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SocialMediaIcons(),
                  const SizedBox(height: 124),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 100,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF252525),
                elevation: 4,
                onPressed: () async {
                  final result = await Get.to(
                    () => EditProfileView(),
                    arguments: user,
                  );
                  if (result != null) {
                    controller.fetchCurrentUserData();
                  }
                },
                child: const Icon(Icons.edit, color: Colors.white, size: 28),
              ),
            ),
          ],
        );
      }),
    );
  }
}
