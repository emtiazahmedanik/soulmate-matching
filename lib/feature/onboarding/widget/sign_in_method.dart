import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class SignInMethod extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback ontap;
  const SignInMethod({
    super.key,
    required this.icon,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF0E1503),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, height: 24, width: 24),
              SizedBox(width: 8),
              Text(
                text,
                style: globalTextStyle(
                  color: Color(0xFFDFB839),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
