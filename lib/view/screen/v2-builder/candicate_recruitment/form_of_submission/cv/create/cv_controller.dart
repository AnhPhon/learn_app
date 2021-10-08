

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2CvController extends GetxController{
  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();
  

  ///
  /// Xem trươc 
  ///
  void onClickPreviewButton(){
    Get.toNamed(AppRoutes.V2_PREVIEW);
  }

}