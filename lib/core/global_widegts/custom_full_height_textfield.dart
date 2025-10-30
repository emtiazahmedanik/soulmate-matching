import 'package:flutter/material.dart';

class CustomFullHeightTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomFullHeightTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 155,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: null, // Allow multiple lines
        expands: true, // Fill the entire height
        textAlignVertical: TextAlignVertical.top, // Start from top
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          hintText: "Write something about you...",
          hintStyle: TextStyle(
            color: Color(0xFFA6AAB3),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          border: InputBorder.none,
          isCollapsed: true,
        ),
      ),
    );
  }
}
