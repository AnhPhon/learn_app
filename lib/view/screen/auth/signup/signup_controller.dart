

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';

class SignUpController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onToPageLogin(){
    Get.toNamed(AuthRoutes.LOGIN);
  }
  
  void onToPageVerify(){
    Get.toNamed(AuthRoutes.VERIFY);
  }

}