import 'package:get/get.dart';

class UpgradePlanController extends GetxController{
    final plans = [
    {
      "plan_name": "Basic",
      "price": 0,
      "access_list": [
        "Create and Edit Profile",
        "Swipe Match",
        "Limited Daily Swipes",
      ],
    },
    {
      "plan_name": "Premium",
      "price": 9.99,
      "access_list": [
        "All Free Membership Features",
        "Daily 10 Favor",
        "Unlimited Daily Swipes",
        "Able to directly send date ideas before matching",
      ],
    },
  ].obs;
  final selectedSubscription = ''.obs;

}