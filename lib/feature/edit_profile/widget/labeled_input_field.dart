import 'package:flutter/material.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? initialValue;
  final int? maxLines;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Widget? suffix;

  const LabeledInputField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.enabled = true,
    this.initialValue,
    this.maxLines = 1,
    this.style,
    this.decoration,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          initialValue: initialValue,
          maxLines: maxLines,
          style: style ?? const TextStyle(color: Colors.white),
          decoration: decoration,
        ),
      ],
    );
  }
}
