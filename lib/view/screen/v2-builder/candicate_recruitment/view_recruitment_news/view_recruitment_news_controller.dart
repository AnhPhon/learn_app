

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/dialog_content.dart';

class V2ViewRecruitmentNewsController extends GetxController{
  final searchController = TextEditingController();
  bool isSearch = false;
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


  void onChangedStatus(){
    isSearch = !isSearch;
    print("Change");
    update();
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