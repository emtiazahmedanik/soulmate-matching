import 'dart:ui';
import 'package:elias_creed/feature/message/screen/user_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elias_creed/feature/home/view/home_view.dart';
import 'package:elias_creed/feature/matches/view/matches_view.dart';
import 'package:elias_creed/core/const/icons_path.dart';
import 'package:elias_creed/feature/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:elias_creed/feature/profile/screen/profile_screen.dart';

class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({super.key});

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<String> titles = ['Home', 'Matches', 'Chat', 'Profile'];
  final List<String> selectedImages = [
    IconsPath.selectedHome,
    IconsPath.selectedMatches,
    IconsPath.selectedMessage,
    IconsPath.selectedProfile,
  ];
  final List<String> unselectedImages = [
    IconsPath.unselectedHome,
    IconsPath.unselectedMatches,
    IconsPath.unselectedMessage,
    IconsPath.unselectedProfile,
  ];

  final List<Widget> pages = [
    HomeView(),
    MatchesView(),
    ChatPage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => Stack(
          children: [
            // Fullscreen Page
            Positioned.fill(child: pages[controller.currentIndex.value]),

            // Bottom Navbar
            Positioned(
              left: (MediaQuery.of(context).size.width - width) / 2,
              right: (MediaQuery.of(context).size.width - width) / 2,
              bottom: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBFBF1A).withAlpha(25),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        bool isSelected =
                            controller.currentIndex.value == index;

                        return GestureDetector(
                          onTap: () => controller.changeIndex(index),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                isSelected
                                    ? selectedImages[index]
                                    : unselectedImages[index],
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                titles[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF78C8FF)
                                      : Colors.white,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
