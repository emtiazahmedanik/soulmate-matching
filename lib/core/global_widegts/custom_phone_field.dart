import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final Color hintTextColor;
  final Color textColor;
  final TextEditingController controller;

  const CustomPhoneField({
    super.key,
    required this.hintText,
    required this.backgroundColor,
    required this.hintTextColor,
    required this.textColor,
    required this.controller,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isValid ? const Color(0xFF78828A) : Colors.red,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: IntlPhoneField(
          controller: widget.controller,
          dropdownIcon: Icon(Icons.arrow_drop_down, color: widget.textColor),
          showDropdownIcon: true,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          disableLengthCheck: true,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            counterText: "",
            hintStyle: globalTextStyle(
              color: widget.hintTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
          ),
          initialCountryCode: 'BD',
          textAlignVertical: TextAlignVertical.center,
          onChanged: (phone) {
            setState(() {
              isValid = phone.number.length >= 10; // Example validation
            });
          },
          onCountryChanged: (country) {
            // Optional country change handler
          },
        ),
      ),
    );
  }
}
