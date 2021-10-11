import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class V2PointBasedController extends GetxController {
  final startController = TextEditingController();
  final endController = TextEditingController();

  String title = "Tổng đơn";

  List titleTabBar = [
    "Đơn đang xử lý",
    "Đơn đã hoàn thành",
  ];

  int currentIndex = 0;

  @override
  void onClose() {
    super.onClose();
    startController.dispose();
    endController.dispose();
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }
}
