import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color color;
  final double? width;
  final double? radius;
  final Color? textColor;
  final double? verticalPadding;
  final Color? borderColor;
  const CustomButton({
    super.key,
    required this.title,
    required this.ontap,
    required this.color,
    this.width = double.infinity,
    this.textColor = Colors.black,
    this.verticalPadding = 14,
    this.borderColor = Colors.transparent,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 32),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 17),
          child: Center(
            child: Text(
              title,
              style: globalTextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
