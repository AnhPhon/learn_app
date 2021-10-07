import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/point_based/point_based_controller.dart';

class V1PointBasedPage extends GetView<V1PointBasedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PointBasedController>(
        init: V1PointBasedController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
