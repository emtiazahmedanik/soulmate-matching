import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),
              const Icon(Icons.logout),
            ],
          ),
        ),
      ),
    );
  }
}
