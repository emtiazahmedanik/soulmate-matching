import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoCarouselController extends GetxController {
  final RxInt currentPage = 0.obs;
  final pageController = Rxn<PageController>();
  Timer? _timer;

  void startAutoSlide(int length) {
    stopAutoSlide();
    if (length <= 1) return;

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.value?.hasClients ?? false) {
        final nextPage = (currentPage.value + 1) % length;
        pageController.value!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoSlide() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    stopAutoSlide();
    super.onClose();
  }
}
