import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
