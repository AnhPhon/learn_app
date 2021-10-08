

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/dialog_content.dart';

class V2RecruitmentController extends GetxController{
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

  ///
  /// Thay đồi trạng thái là tìm kiếm 
  ///
  void onChangedStatus(){
    isSearch = !isSearch;
    update();
  }

  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews(){
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }

  ///
  /// Nhấn vào icon lịch sử trên appbar
  ///
  void onClickHistory(){
    Get.toNamed(AppRoutes.V2_HISTORY_RECRUITMENT_NEWS);
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