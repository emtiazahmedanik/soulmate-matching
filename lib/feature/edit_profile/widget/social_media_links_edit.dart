import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/edit_profile_controller.dart';

class SocialMediaLinksEdit extends StatelessWidget {
  SocialMediaLinksEdit({super.key});
  final EditProfileController controller = Get.find<EditProfileController>();
  


  final List<SocialIconData> icons = [
    SocialIconData('facebook', FontAwesomeIcons.facebookF, Color(0xFF1877F2)),
    SocialIconData('instagram', FontAwesomeIcons.instagram, Color(0xFFE1306C)),
    SocialIconData('tiktok', FontAwesomeIcons.tiktok, Colors.white),
    SocialIconData('twitter', FontAwesomeIcons.xTwitter, Color(0xFF1D9BF0)),
    SocialIconData('linkedin', FontAwesomeIcons.linkedinIn, Color(0xFF0A66C2)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Social Media',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        ...icons.map(
          (data) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
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
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: controller.socialLinks[data.key] ?? '',
                    ),
                    onChanged: (val) => controller.socialLinks[data.key] = val,
                    style: const TextStyle(color: Color(0xFFEBEBEB)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF252525),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF78C8FF)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      hintText: 'https://${data.key}.com/username',
                      hintStyle: const TextStyle(color: Color(0xFFEBEBEB)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SocialIconData {
  final String key;
  final IconData icon;
  final Color color;

  const SocialIconData(this.key, this.icon, this.color);
}
