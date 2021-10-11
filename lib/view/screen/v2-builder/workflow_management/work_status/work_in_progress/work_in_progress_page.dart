import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/work_in_progress_controller.dart';

class V2WorkInProgressPage extends GetView<V2WorkInProgressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Việc đang làm",
      ),
      body: GetBuilder<V2WorkInProgressController>(
          init: V2WorkInProgressController(),
          builder: (V2WorkInProgressController controller) {
            return Column();
          }),
    );
  }
}
