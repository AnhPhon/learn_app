import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/job_management/job_management_controller.dart';

class V3JobManagementPage extends GetView<V3JobManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3JobManagementController>(
        init: V3JobManagementController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
