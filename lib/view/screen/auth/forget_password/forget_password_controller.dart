import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';

class ForgetPasswordController extends GetxController {
  bool isEnalbeConfirm = true;

  @override
  void onInit() {
    super.onInit();
  }

  void onConfirm() {
    // TODO: Do something
    onToPageUpdatePassword();
    isEnalbeConfirm = !isEnalbeConfirm;
    update();
  }

  // Router page

  ///
  /// back to page login
  ///
  void onBack() {
    Get.back();
  }

  void onToPageUpdatePassword() {
    Get.toNamed(AuthRoutes.UPDATE_PASSWORD);
  }
}
