import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/work_done_controller.dart';

class V2WorkDonePage extends GetView<V2WorkDoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Việc đã làm",
      ),
      body: GetBuilder<V2WorkDoneController>(
          init: V2WorkDoneController(),
          builder: (V2WorkDoneController controller) {
            return Column();
          }),
    );
  }
}
