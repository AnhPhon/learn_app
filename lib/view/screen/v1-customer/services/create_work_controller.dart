

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class CreateWorkController extends GetxController{
  final addressController = TextEditingController();

  void onClickContinue(int group){
    // group là một nhóm
    if(group == 1){
      // Nhóm 1
      Get.toNamed(AppRoutes.V1_G1CREATEWORK);
    }
  }

}