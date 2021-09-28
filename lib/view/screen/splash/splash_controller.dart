import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController!
        .forward()
        .whenComplete(() => Get.offNamed(AppRoutes.INTRO));

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    print('on onClose');
    _animationController!.dispose();
  }
}
