

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2TextTypingController extends GetxController{
  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();


  // Tiêu đề
  // Công ty
  final companyController = TextEditingController();
  // địa chỉ
  // miêu tả
  final descController = TextEditingController();
  //yêu cẩu
  final requiredController = TextEditingController();
  // quyền lợi
  final benifitController = TextEditingController();
  // Ưu tiên
  final prioritizedController = TextEditingController();
  // Hạn nộp
  final endTimeController = TextEditingController();
  // name
  final nameController = TextEditingController();
  //phone
  final phoneController = TextEditingController();
  // contact address
  final contactAddressController = TextEditingController();
  // email
  final emailController = TextEditingController();
  // email
  final amountController = TextEditingController();


  ///
  /// Nhân vào xem trước hồ sơ
  ///
  void onClickPreviewButton(){
    Get.toNamed(AppRoutes.V2_PREVIEW_PROFILE);
  }



}