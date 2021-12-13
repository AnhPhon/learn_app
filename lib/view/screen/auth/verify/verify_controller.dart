

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';


class VerifyController extends GetxController{

  @override
  void onInit() {
    super.onInit();
  }

  void onToPageSignUp(){
    Get.toNamed(AuthRoutes.VERIFY);
  }

}