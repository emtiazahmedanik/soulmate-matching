import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveCallScreen extends StatelessWidget {
  final String phoneNumber;

  const ActiveCallScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040404),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Section: Call Info
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  const Text(
                    'Calling...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Support Team',
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Call Duration (Placeholder)
                  Text(
                    '00:00',
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Middle Section: Call Animation
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ignore: deprecated_member_use
                color: Colors.blueAccent.withOpacity(0.2),
              ),
              child: const Center(
                child: Icon(
                  Icons.phone_in_talk,
                  size: 48,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            // Bottom Section: Call Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute Button
                  _buildCallControlButton(
                    icon: Icons.mic_off,
                    label: 'Mute',
                    onPressed: () {},
                  ),
                  // Speaker Button
                  _buildCallControlButton(
                    icon: Icons.volume_up,
                    label: 'Speaker',
                    onPressed: () {},
                  ),
                  // End Call Button
                  _buildCallControlButton(
                    icon: Icons.call_end,
                    label: 'End Call',
                    onPressed: () => Get.back(),
                    isEndCall: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isEndCall = false,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEndCall
            // ignore: deprecated_member_use
                ? Colors.red.withOpacity(0.2)
                // ignore: deprecated_member_use
                : Colors.white.withOpacity(0.1),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: isEndCall ? Colors.red : Colors.white,
              size: 30,
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          // ignore: deprecated_member_use
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ],
    );
  }
}
