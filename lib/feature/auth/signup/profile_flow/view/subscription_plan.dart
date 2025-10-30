import 'package:elias_creed/core/style/global_text_style.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/controller/profile_flow_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlan extends StatelessWidget {
  SubscriptionPlan({super.key});

  final ProfileFlowController controller = Get.find<ProfileFlowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Subscription Plan",
          style: globalTextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 30),
        child: Obx(
          () => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.plans.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> plan = controller.plans[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFF252525),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan['plan_name'] ?? '',
                      style: globalTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$${plan['price']}",
                      style: globalTextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...List.generate(
                      (plan['access_list'] as List).length,
                      (i) => Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green, size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                plan['access_list'][i],
                                style: globalTextStyle(
                                  color: Color(
                                    0xFFCCCCCC,
                                  ).withValues(alpha: 0.8),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Color(0xFF525252)),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          controller.selectedSubscription.value =
                              plan['plan_name'];
                          controller.submit((plan['price'] as num).toDouble());
                        },
                        child: Text(
                          "Purchase Plan",
                          style: globalTextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
