import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V4WorkProgressController extends GetxController
    with SingleGetTickerProviderMixin {
  //set model để thiết kế UI tiến độ công việc
  List<Map<String, dynamic>>? uiWorkProgress;
  //khai báo seleceted Index
  int selectedIndex = 0;

  //khai báo isLoading
  bool isLoading = true;

  TabController? tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get worl progress
    selectedIndex = int.parse(Get.parameters['tabIndex'].toString());
    //List model thiết kế UI
    uiWorkProgress = [
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng A trục A",
        "description": "Phòng D,E,F của công trình A",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -2,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng B trục B",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -10,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -3,
        "status": true,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": 22,
      }
    ];
  }
}
