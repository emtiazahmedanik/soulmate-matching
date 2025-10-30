import 'package:flutter/material.dart';

class AboutMeInput extends StatelessWidget {
  final TextEditingController controller;
  const AboutMeInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About me',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 5,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF252525),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF78C8FF)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 18,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
