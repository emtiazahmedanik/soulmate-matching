import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpInputField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;

  const OtpInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 50,
      textStyle: globalTextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF979797), width: 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF979797), width: 1),
      ),
    );

    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      cursor: Container(width: 1, height: 20, color: Colors.white),
      onCompleted: (otp) {
        if (kDebugMode) {
          print("Entered OTP: $otp");
        }
        controller.otpCode.value = otp;
      },
    );
  }
}
