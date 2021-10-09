import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/revenue/revenue_controller.dart';

class V3RevenuePage extends GetView<V3RevenueController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3RevenueController>(
        init: V3RevenueController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
