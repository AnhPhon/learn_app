

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/dialog_content.dart';

class V1CandidateController extends GetxController{
  final searchController = TextEditingController();
  int currentIndex = 0;
  // Value slider 
  double salary = 0;

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index){
    currentIndex = index;
    update();
  }

  ///
  /// thay đổi lương
  ///
  void onChangedSalary(double salary){
    this.salary = salary;
    update();
  }

  ///
  /// Onlick đến đơn tạo tuyển ứng viên
  ///
  void onClickFloatButton(){
    Get.toNamed(AppRoutes.V1_G7_RECRUITMENT);
  }
  ///
  /// Onlick đến xem thông tin hồ sơ ưng tuyển
  ///
  void onClickProfile(){
    Get.toNamed(AppRoutes.V1_CANDICATE_PROFILE);
  }

  /// 
  ///  Hiẻn thị bộ lọc
  /// 
  void showDialog(){
    Get.defaultDialog(
      title: "",
      content: const DialogContent(),
      cancel: ElevatedButton(onPressed: (){
        Navigator.of(Get.context!).pop();
      }, child: const Text("Tìm kiếm"))
    );
  }

}