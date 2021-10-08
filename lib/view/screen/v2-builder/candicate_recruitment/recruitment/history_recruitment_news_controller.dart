

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2HistoryRecruitmentNewsController extends GetxController{
  final searchController = TextEditingController();
  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews(){
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }


}