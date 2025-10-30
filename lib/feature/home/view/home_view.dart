import 'package:cached_network_image/cached_network_image.dart';
import 'package:elias_creed/core/const/icons_path.dart';
import 'package:elias_creed/feature/subscription/screen/upgrade_plan.dart';
import 'package:elias_creed/feature/user_profile/view/user_profile_view.dart'
    show UserProfileView;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:elias_creed/feature/home/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.users.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final user = controller.users[controller.currentIndex.value];

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // ✅ Background Image with Cache + Shimmer
            CachedNetworkImage(
              imageUrl: user.photos.isNotEmpty ? user.photos[0] : '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(color: Colors.grey[300]),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.red),
              ),
            ),

            // Semi-transparent Overlay
            Container(color: Colors.black.withValues(alpha: 0.5)),

            // Top Row with Profile and Notification Icons
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 55,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(UpGradePlan());
                      },
                      child: Image.asset(
                        'assets/icons/appcon.png',
                        width: 39,
                        height: 50,
                      ),
                    ),
                    Image.asset(
                      IconsPath.notificationIcon,
                      width: 31,
                      height: 31,
                    ),
                  ],
                ),
              ),
            ),

            // Card Swiper Center
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: CardSwiper(
                  cardsCount: controller.users.length,
                  numberOfCardsDisplayed: 1,
                  onSwipe: (previousIndex, currentIndex, direction) {
                    if (direction == CardSwiperDirection.left) {
                      if (kDebugMode) print("left");
                    } else if (direction == CardSwiperDirection.right) {
                      if (kDebugMode) print("right");
                    }
                    if (currentIndex != null) {
                      controller.updateIndex(currentIndex);
                    }
                    return true;
                  },
                  cardBuilder: (context, index, percentX, percentY) {
                    final user = controller.users[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => UserProfileView(),arguments: user);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // ✅ Cached image with shimmer
                            CachedNetworkImage(
                              imageUrl: user.photos.isNotEmpty
                                  ? user.photos[0]
                                  : '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(color: Colors.grey[300]),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user.name} (${user.age})",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Obx(() {
                                      final position =
                                          controller.currentPosition.value;

                                      if (position == null) {
                                        return const Text(
                                          "Locating...",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        );
                                      }

                                      final userLat =
                                          user.location?['lat'] ?? 0.0;
                                      final userLong =
                                          user.location?['long'] ?? 0.0;

                                      final km = controller
                                          .calculateDistanceKmSync(
                                            position.latitude,
                                            position.longitude,
                                            userLat,
                                            userLong,
                                          );

                                      return Text(
                                        "${km.toStringAsFixed(1)} km away",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
