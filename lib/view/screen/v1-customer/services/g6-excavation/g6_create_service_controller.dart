


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/routes/app_routes.dart';

class V1G6CreateServiceController extends GetxController{
  final workTitleController = TextEditingController();
  final amountController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final distanceController = TextEditingController();
  final workDescController = TextEditingController();

  ///
  /// Nhấn tiếp tục 
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
  }
}