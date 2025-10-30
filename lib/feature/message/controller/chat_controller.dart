import 'package:elias_creed/core/services_class/shared_preference/shared_preferences_helper.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString currentUserId = RxString('');

  @override
  void onInit() {
    loadCurrentUserId();
    super.onInit();
  }

  void loadCurrentUserId() async {
    currentUserId.value = await SharedPreferencesHelper.getUserUid() ?? '';
  }

    Future<String> getChatId(String otherUserId) async {
    String uid1 = currentUserId.value;
    String uid2 = otherUserId;
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

}
