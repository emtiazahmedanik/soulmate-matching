import 'package:cached_network_image/cached_network_image.dart';
import 'package:elias_creed/feature/user_profile/view/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elias_creed/feature/matches/controller/matches_controller.dart';
import 'package:shimmer/shimmer.dart';

class MatchesView extends StatelessWidget {
  MatchesView({super.key});

  final MatchesController controller = Get.put(MatchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Matches",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 92),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: controller.matches.length,
          itemBuilder: (context, index) {
            final matchUser = controller.matches[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => UserProfileView(),arguments: matchUser);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image with CachedNetworkImage + Shimmer
                      CachedNetworkImage(
                        imageUrl: matchUser.photos.isNotEmpty
                            ? matchUser.photos[0]
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
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      // Gradient overlay
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

                      // Content
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${matchUser.name} (${matchUser.age})",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Obx(() {
                              final position = controller
                                  .homeController
                                  .currentPosition
                                  .value;

                              if (position == null) {
                                return const Text(
                                  "Locating...",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                );
                              }

                              final userLat = matchUser.location?['lat'] ?? 0.0;
                              final userLong =
                                  matchUser.location?['long'] ?? 0.0;

                              final km = controller.calculateDistanceKmSync(
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
