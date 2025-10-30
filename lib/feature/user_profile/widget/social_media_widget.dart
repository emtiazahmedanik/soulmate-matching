import 'package:elias_creed/feature/user_profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key, required this.socialLink});
  final Map<String, dynamic> socialLink;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();

    final facebook = (socialLink['facebook'] ?? '').trim();
    final twitter = (socialLink['twitter'] ?? '').trim();
    final tiktok = (socialLink['tiktok'] ?? '').trim();
    final instagram = (socialLink['instagram'] ?? '').trim();
    final linkedin = (socialLink['linkedin'] ?? '').trim();

    // Build icon list and filter out empty URLs
    final List<_SocialIconData> icons = [
      _SocialIconData(
        icon: FontAwesomeIcons.facebookF,
        color: const Color(0xFF1877F2),
        url: facebook,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.instagram,
        color: const Color(0xFFE1306C),
        url: instagram,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.tiktok,
        color: Colors.white,
        url: tiktok,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.xTwitter,
        color: const Color(0xFF1D9BF0),
        url: twitter,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.linkedinIn,
        color: const Color(0xFF0A66C2),
        url: linkedin,
      ),
    ].where((icon) => icon.url.isNotEmpty).toList();

    // If all URLs are empty
    if (icons.isEmpty) {
      return const Center(
        child: Text(
          "No social links available",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons.map((data) {
        return InkWell(
          onTap: () async {
            await controller.openUrlInBrowser(data.url);
          },
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: FaIcon(data.icon, color: data.color, size: 28),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SocialIconData {
  final IconData icon;
  final Color color;
  final String url;
  _SocialIconData({required this.icon, required this.color, required this.url});
}
