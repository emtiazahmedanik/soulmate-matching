import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileController extends GetxController {
  // final List<String> profileImages = [
  //   'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&h=400&fit=crop',
  //   'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400&h=400&fit=crop',
  //   'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400&h=400&fit=crop',
  //   'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400&h=400&fit=crop',
  //   'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400&h=400&fit=crop',
  // ];

  // final String name = 'Monica';
  // final int age = 24;
  // final String gender = 'Girl';
  // final String height = '173 cm';
  // final String weight = '48 kg';
  // final String education = 'University of Arts and Design';
  // final String aboutMe =
  //     "Living life one pose at a time. As a model, I've learned to embrace beauty in all its forms. When I'm not on the runway, I'm exploring new places and creating art with my own unique style.";

  // // Social media placeholder links
  // final Map<String, String> socialLinks = {
  //   'facebook': '#',
  //   'instagram': '#',
  //   'tiktok': '#',
  //   'twitter': '#',
  //   'linkedin': '#',
  // };


    Future<void> openUrlInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // opens in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
