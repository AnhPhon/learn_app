import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V3ProductManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  List categoriesList = [
    "Tất cả",
    "Vật liệu xây dựng",
    "Nội thất",
    "Thiết bị",
  ];

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String title = "Quản lý sản phẩm";

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: categoriesList.length, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }
}
