


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/routes/app_routes.dart';

class V1G7RecruitmentController extends GetxController{
  // Tiêu đề
  final titleController = TextEditingController();
  // Công ty
  final companyController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();
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
  /// Nhấn tiếp tục 
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_G7_REVIEW);
  }
}