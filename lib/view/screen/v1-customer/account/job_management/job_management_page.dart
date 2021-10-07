import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/job_management/job_management_controller.dart';

class V1JobManagementPage extends GetView<V1JobManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1JobManagementController>(
        init: V1JobManagementController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
