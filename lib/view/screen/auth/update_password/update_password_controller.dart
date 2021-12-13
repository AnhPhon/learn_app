

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';


class UpdatePasswordController extends GetxController{

  bool isEnalbeConfirm = true;

  @override
  void onInit() {
    super.onInit();
  }

 

  void onConfirm(){
    // TODO: Do something
    onToPageLogin();
    isEnalbeConfirm = !isEnalbeConfirm;
    update();
  }


  // Router page

  ///
  /// back to page login
  ///
  void onBack(){
    Get.back();
  }

   void onToPageLogin(){
    Get.offAndToNamed(AuthRoutes.LOGIN);
  }

}