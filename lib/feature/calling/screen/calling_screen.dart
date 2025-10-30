import 'package:elias_creed/feature/calling/screen/active_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallingScreen extends StatelessWidget {
  const CallingScreen({super.key});

  // void _makePhoneCall(String phoneNumber) async {
  //   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     Get.snackbar('Error', 'Could not launch phone call');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040404),
      appBar: AppBar(
        backgroundColor: const Color(0xFF040404),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Call Center',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.blueAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone,
                size: 48,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contact Support',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Reach out to our support team for assistance.',
              style: TextStyle(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => const ActiveCallScreen(phoneNumber: '999')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Call Now: 999',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
