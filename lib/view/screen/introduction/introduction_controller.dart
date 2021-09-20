import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:template/routes/app_routes.dart';

class IntroductionController extends GetxController {
  final introKey = GlobalKey<IntroductionScreenState>();

  void onIntroEnd(BuildContext context) {
    Get.offNamed(AppRoutes.LOGIN);
    update();
  }
}
