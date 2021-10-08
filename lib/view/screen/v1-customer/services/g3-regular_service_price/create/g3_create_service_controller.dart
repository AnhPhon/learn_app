


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G3CreateServiceController extends GetxController{
  final workTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final amountController = TextEditingController();
  final valueController = TextEditingController();

  ///
  /// Nhấn tiếp tục tới trang báo giá đơn hàng
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_G3_ORDER_QUOTE);
  }
}