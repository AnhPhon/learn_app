

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G1CreateWorkController extends GetxController{
  final worKTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();


  ///
  /// Nhấn tiếp tục qua trang xem lại đơn tạo
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_G1_REVIEW);
  }


}