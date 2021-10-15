

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G1CreateWorkController extends GetxController{
  final worKTitleController = TextEditingController();
  final descController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final nameTitleController = TextEditingController();
  final specificationController = TextEditingController();

  @override
  void onInit() {
    final data =Get.arguments as Map<String, dynamic>;
    worKTitleController.text = data['jobTitle']  as String;
    print(data);  
  }
  ///
  /// Nhấn tiếp tục qua trang xem lại đơn tạo
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_G1_REVIEW);
  }


  @override
  void onClose() {
    super.onClose();
    worKTitleController.dispose();
    descController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    nameTitleController.dispose();
    specificationController.dispose();
  }

}