import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/routes/route_path/account_management_routers.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/view/screen/home/home_page.dart';

class AccountController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Go to Account Information
  ///
  void onToAccountInformation() {
    Get.toNamed(AccountRoutes.ACCOUNT_INFOMATION);
  }

  ///
  ///Go to Account Managements
  ///
  void goToAccountManagements() {
    Get.toNamed(AccountManagementRouter.ACCOUNT_MANAGEMENT);
  }
}
