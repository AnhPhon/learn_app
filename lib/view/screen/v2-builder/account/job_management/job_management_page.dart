import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/account/job_management/job_management_controller.dart';

class V2JobManagementPage extends GetView<V2JobManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2JobManagementController>(
        init: V2JobManagementController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
