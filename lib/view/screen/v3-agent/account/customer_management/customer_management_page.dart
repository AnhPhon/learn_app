import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/customer_management/customer_management_controller.dart';

class V3CustomerManagementPage extends GetView<V3CustomerManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3CustomerManagementController>(
      init: V3CustomerManagementController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBarWidget(title: controller.title),
      );
    });
  }
}
