

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
    // Nếu dich vụ thì chỉ có nhóm 3, 4, 5, 6, 7
    // Nếu tạo công việc chỉ có mhóm 1, 2 , 5 ,6 
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
    }else if(group == 4){
      // Tạo đơn dich vụ có giá nhóm 4
      Get.toNamed(AppRoutes.V1_G4_CREATE_SERVICE);
    }else if(group == 5){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G5_CREATE_SERVICE);
    }else if(group == 6){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G6_CREATE_SERVICE);
    }
  }

}