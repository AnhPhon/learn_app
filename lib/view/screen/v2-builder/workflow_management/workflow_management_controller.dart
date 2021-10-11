import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2WorkflowManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  //set model để thiết kế UI Quản lý công việc
  List<Map<String, dynamic>>? uiWorkflowManagement;

  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isRecruiting
  bool isRecruiting = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //List model thiết kế UI
    uiWorkflowManagement = [
      {
        "job": "Thợ ốp lát",
        "title": "Công trình khách hàng 4 sao tại Đà Nẵng",
        "city": "Đà Nẵng",
        "address": "Ngũ Hành Sơn",
        "status": "Còn 35 ngày",
        "isStatus": false,
        "result": "Chưa nghiệm thu",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ xây tường",
        "title": "Công trình khách hàng 5 sao tại Đà Nẵng",
        "city": "Đà Nẵng",
        "address": "Ngũ Hành Sơn",
        "status": "Đang tuyển",
        "isStatus": true,
        "result": "Đã nghiệm thu",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ lót nền",
        "title": "Công trình khách hàng 4 sao tại Hồ Chí Minh",
        "city": "Hồ Chí Minh",
        "address": "Ngũ Hành Sơn",
        "status": "Còn 20 ngày",
        "isStatus": false,
        "result": "Đã quyết toán",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ xây tường",
        "title": "Công trình khách hàng 3 sao tại Hồ Chí Minh",
        "city": "Hồ Chí Minh",
        "address": "Ngũ Hành Sơn",
        "status": "Đang tuyển",
        "isStatus": true,
        "result": "20/08/2021",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
    ];
  }

  ///
  ///Click to Work done page
  ///
  void onClickToWorkDonePage() {
    Get.toNamed(AppRoutes.V2_WORK_DONE);
  }

  ///
  ///Click to Work in progress
  ///
  void onClickToWorkInProgressPage() {
    Get.toNamed(AppRoutes.V2_WORK_IN_PROGRESS);
  }
}
