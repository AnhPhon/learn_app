import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class IntroductionController extends GetxController {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void onInit() {
    sl.get<SharedPreferenceHelper>().isFirst.then((value) {
      print(value);
      if (value == true) {
        Get.offNamed(AppRoutes.LOGIN);
      }
    });

    super.onInit();
  }

  void onIntroEnd(BuildContext context) {
    sl.get<SharedPreferenceHelper>().saveIsFirst(true);
    Get.offNamed(AppRoutes.LOGIN);
    update();
  }
}
