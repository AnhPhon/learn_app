import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class NewsController extends GetxController with SingleGetTickerProviderMixin{

  TabController? tabController;

  @override
  void onInit() {
    this.tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

}
