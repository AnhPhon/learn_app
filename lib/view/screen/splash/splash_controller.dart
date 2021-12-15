

import 'package:flutter/material.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:get/get.dart';


class SplashController extends GetxController with SingleGetTickerProviderMixin{
late AnimationController? _animationController;
  @override
  void onInit() {
    print("Abc");
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
     _animationController!.forward().whenComplete(() async {
       Get.toNamed(SplashRoutes.ON_BOARDING);
     });
  }
}