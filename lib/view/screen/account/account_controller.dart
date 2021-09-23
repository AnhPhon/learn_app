import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:template/routes/app_routes.dart';

class AccountController extends GetxController {
  var counter = 1.obs;

  var orderPages = 0.obs; 

  bool isLoading = true;

  // tới màn hình rules
  void onRulesClick() {
    Get.toNamed(AppRoutes.RULES);
  }

  //đăng xuất
  void onLogoutClick() {
    Get.offNamed(AppRoutes.LOGIN);
  }

  //tới màn hình order
  void onOrderClick(int? index) {
    if (index == 1) {
      orderPages.value = 1;
    } else if (index == 2) {
      orderPages.value = 2;
    } else if (index == 3) {
      orderPages.value = 3;
    } else {
      orderPages.value = 0;
    }
    update();
    Get.toNamed(AppRoutes.ORDER);
  }
 
}
