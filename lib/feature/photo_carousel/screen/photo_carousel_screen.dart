import 'package:cached_network_image/cached_network_image.dart';
import 'package:elias_creed/feature/photo_carousel/controller/photo_carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoCarousel extends StatelessWidget {
  final List<String> photos;
  final double height;
  final BorderRadius borderRadius;

  const PhotoCarousel({
    super.key,
    required this.photos,
    this.height = 320,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PhotoCarouselController(),
      tag: hashCode.toString(),
    );
    controller.pageController.value = PageController();
    controller.startAutoSlide(photos.length);

    if (photos.isEmpty) {
      return Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: borderRadius,
        ),
        child: const Icon(Icons.person, color: Colors.white, size: 80),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: PageView.builder(
              controller: controller.pageController.value,
              itemCount: photos.length,
              onPageChanged: (i) => controller.currentPage.value = i,
              itemBuilder: (context, index) {
                final photoUrl = photos[index];
                return CachedNetworkImage(
                  imageUrl: photoUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey.shade100),
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
            ),
          ),

          // Indicators
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Obx(() {
              final current = controller.currentPage.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(photos.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: current == i ? 32 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: current == i
                          ? const Color(0xFFFE3C72)
                          : Colors.white.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
