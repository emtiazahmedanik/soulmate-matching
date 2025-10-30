// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/profile_controller.dart';
// import '../widget/profile_photo_carousel.dart';
// import '../widget/social_media_icons.dart';
// import 'package:elias_creed/feature/edit_profile/view/edit_profile_view.dart';

// class ProfileView extends StatelessWidget {
//   ProfileView({super.key});
//   final ProfileController controller = Get.put(ProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF040404),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF040404),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
//           onPressed: () {},
//         ),
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
              
//             },
//             child: const Text(
//               'UPGRADE',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//                 letterSpacing: 0.2,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24,
//             ).copyWith(bottom: 32),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 const Center(child: ProfilePhotoCarousel()),
//                 const SizedBox(height: 24),
//                 // My Matches button (left-aligned text)
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF252525),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 16,
//                         horizontal: 20,
//                       ),
//                       elevation: 0,
//                       alignment: Alignment.centerLeft,
//                     ),
//                     onPressed: () {},
//                     child: const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'My Matches',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   '${controller.name} (${controller.age})',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 // Vertically aligned details
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.female, color: Colors.white, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           controller.gender,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.height, color: Colors.white, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           controller.height,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.monitor_weight,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           controller.weight,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(Icons.school, color: Colors.white, size: 20),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         controller.education,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 const Divider(color: Color(0xFF252525), height: 1),
//                 const SizedBox(height: 24),
//                 Text(
//                   'About me',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   controller.aboutMe,
//                   style: const TextStyle(
//                     color: Color(0xFFCCCCCC),
//                     fontSize: 18,
//                     height: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Remove the edit button under About Me
//                 const SizedBox(height: 32),
//                 Text(
//                   'Social Media',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 SocialMediaIcons(),
//                 const SizedBox(height: 80), // Space for floating edit button
//               ],
//             ),
//           ),
//           // Floating Edit Button (bottom right, above social icons)
//           Positioned(
//             right: 16,
//             bottom: 100,
//             child: FloatingActionButton(
//               backgroundColor: const Color(0xFF252525),
//               elevation: 4,
//               onPressed: () {
//                 Get.to(() => EditProfileView());
//               },
//               child: const Icon(Icons.edit, color: Colors.white, size: 28),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
