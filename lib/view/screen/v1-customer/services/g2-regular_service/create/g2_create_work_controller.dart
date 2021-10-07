


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/routes/app_routes.dart';

class V1G2CreateWorkController extends GetxController{
  final workTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final valueController = TextEditingController();
  final massDesc = TextEditingController();
  final workDesc = TextEditingController();

  ///
  /// Nhấn tiếp tục 
  ///
  void onClickContinueButton(){
    Get.offAll(AppRoutes.V1_SUCCESSFULLY);
  }
}