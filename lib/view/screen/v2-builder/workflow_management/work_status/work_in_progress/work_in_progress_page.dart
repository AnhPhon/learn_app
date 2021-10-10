import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/workflow_management/workflow_management_controller.dart';

///
/// Lấy V2WorkflowManagementController để dùng Model ở Workflow Management nhằm
/// mục đích khi click các item tương ứng trong danh sách việc đang làm
///
class V2WorkInProgressPage extends GetView<V2WorkflowManagementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Việc đang làm",
      ),
      body: GetBuilder<V2WorkflowManagementController>(
          init: V2WorkflowManagementController(),
          builder: (V2WorkflowManagementController controller) {
            return Column();
          }),
    );
  }
}
