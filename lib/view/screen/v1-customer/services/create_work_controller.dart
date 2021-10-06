

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class CreateWorkController extends GetxController{
  final addressController = TextEditingController();
  int group = 1;
  List<int> workGroupList = [];

  @override
  void onInit() {
    super.onInit();
    workGroupList = [1,2,3,4,5,6,7];
  }

  ///
  /// Thay đổi nhóm công việc
  ///
  void onChangedGroup(int group){
    print(group);
    this.group = group;
    update();
  }

  ///
  /// Nhấn vào nút tiếp tục
  ///
  void onClickContinue(){
    if(group == 1){
      // Nhóm 1
      Get.toNamed(AppRoutes.V1_G1_CREATE_WORK);
    }else if(group == 2){
      Get.toNamed(AppRoutes.V1_G2_CREATE_WORK);
    }else if( group == 3){
      // Tạo đơn dịch vụ có gía
      Get.toNamed(AppRoutes.V1_G3_CREATE_SERVICE);
    }
  }

}