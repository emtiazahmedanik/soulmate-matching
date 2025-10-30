import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class ProfilePhotoCarousel extends StatefulWidget {
  const ProfilePhotoCarousel({super.key});

  @override
  State<ProfilePhotoCarousel> createState() => _ProfilePhotoCarouselState();
}

class _ProfilePhotoCarouselState extends State<ProfilePhotoCarousel> {
  final ProfileController controller = Get.find();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-slide timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && controller.userProfile.value != null) {
        final photos = controller.userProfile.value!.photos;
        if (photos.isEmpty) return;
        final nextPage = (_currentPage + 1) % photos.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.userProfile.value;

      // Show loader if no data yet
      if (user == null || user.photos.isEmpty) {
        return Container(
          height: 320,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 80),
        );
      }

      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 320,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: user.photos.length,
                itemBuilder: (context, index) {
                  final photoUrl = user.photos[index];
                  return CachedNetworkImage(
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 320,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade100,
                      //child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                onPageChanged: (i) => setState(() => _currentPage = i),
              ),
            ),
          ),

          // Page indicators
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(user.photos.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 32 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? const Color(0xFFFE3C72)
                        : Colors.white.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
