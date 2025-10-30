import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/profile_controller.dart';

class SocialMediaIcons extends StatelessWidget {
  SocialMediaIcons({super.key});
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final socialLink = controller.userProfile.value!.socialMedia;
    final facebook = socialLink['facebook'] ?? '';
    final twitter = socialLink['twitter'] ?? '';
    final tiktok = socialLink['tiktok'] ?? '';
    final instagram = socialLink['instagram'] ?? '';
    final linkedin = socialLink['linkedin'] ?? '';

    final List<_SocialIconData> icons = [
      _SocialIconData(
        icon: FontAwesomeIcons.facebookF,
        color: Color(0xFF1877F2),
        url: facebook,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.instagram,
        color: Color(0xFFE1306C),
        url: instagram,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.tiktok,
        color: Colors.white,
        url: tiktok,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.xTwitter,
        color: Color(0xFF1D9BF0),
        url: twitter,
      ),
      _SocialIconData(
        icon: FontAwesomeIcons.linkedinIn,
        color: Color(0xFF0A66C2),
        url: linkedin,
      ),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons.map((data) {
        return InkWell(
          onTap: () async{
            debugPrint('url: ${data.url}');
            if(data.url.isNotEmpty){
              await controller.openUrlInBrowser(data.url);
            }
            
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
