

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';


class LoginController extends GetxController{

  @override
  void onInit() {
    super.onInit();
  }

  void onToPageSignUp(){
    Get.toNamed(AuthRoutes.SIGN_UP);
  }

  void onToPageForgetPassword(){
    Get.toNamed(AuthRoutes.FORGET_PASSWORD);
  }

}