import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    // pageController.addListener(() {
    //   onChangeIndex(1);
    // });
  }

  void onChangeIndex(int index) {
    currentIndex = index;
    update();
  }

  //// init
  /// On complate
  ///
  void onComplete() {
    Get.offAndToNamed(AuthRoutes.LOGIN);
  }

  void onSaveSplash() {
    GetIt.instance.get<SharedPreferenceHelper>().setSplash(
          status: true,
        );
  }
}
