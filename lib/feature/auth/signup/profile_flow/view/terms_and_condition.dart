import 'package:elias_creed/core/global_widegts/custom_button.dart';
import 'package:elias_creed/core/style/global_text_style.dart'
    show globalTextStyle;
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/subscription_plan.dart'
    show SubscriptionPlan;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatelessWidget {
  TermsAndCondition({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and condition",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Read all terms and condition carefully ",
                style: globalTextStyle(
                  color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Terms and condition",
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '''Last updated: January 2025

Welcome to Unity! By using our app or website, you agree to the following terms and conditions.

1. Eligibility  
You must be at least 18 years old to use our services.

2. Account Creation  
To use the app, you must create an account and provide accurate information. You are responsible for your account and activities.

3. Acceptable Use  
You agree to use the platform responsibly. Don’t engage in harassment, post illegal content, or impersonate others.

4. Privacy  
We collect personal data as described in our Privacy Policy. By using our services, you consent to this data collection.

5. In-App Purchases  
Our app may offer paid features. By purchasing, you agree to the terms and payment fees.

6. Content  
You own the content you share, but you grant us a license to use it within the app. We may remove inappropriate content.

7. Termination  
We can suspend or terminate your account for violations of these terms. You may also delete your account at any time.

8. Limitation of Liability  
We’re not liable for any losses or damages from using the app. Use it at your own risk.

9. Changes  
We may update these terms at any time. Continued use of the app means you accept the changes.''',
                textAlign: TextAlign.start,
                style: globalTextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 40),
              CustomButton(
                title: "Agree all terms & condition",
                ontap: () {
                  Get.to(() => SubscriptionPlan());
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
