import 'dart:ui';
import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final bool isNumber;

  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(isObscure);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            border: Border.all(color: const Color(0xFF979797), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: isObscure
                ? ValueListenableBuilder<bool>(
                    valueListenable: obscureNotifier,
                    builder: (context, obscure, _) {
                      return _buildTextField(obscureNotifier, obscure);
                    },
                  )
                : _buildTextField(null, false),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(ValueNotifier<bool>? notifier, bool obscure) {
    return Center(
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: globalTextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          hintText: hintText,
          hintStyle: globalTextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8, right: 12),
                  child: SizedBox(width: 24, height: 24, child: prefixIcon),
                )
              : null,
          prefixIconConstraints: prefixIcon != null
              ? const BoxConstraints(minWidth: 40, minHeight: 40)
              : null,
          suffixIcon:
              suffixIcon ??
              (notifier != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () => notifier.value = !notifier.value,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    )
                  : null),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
