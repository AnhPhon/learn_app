import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';
import 'package:template/view/screen/v4-employee/report/report_controller.dart';

class V4ReportPage extends GetView<V4ReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Danh sách báo cáo",
      ),
      body: GetBuilder<V4ReportController>(
          init: V4ReportController(),
          builder: (V4ReportController controller) {
            return const Center(
              child: Text("Report Page"),
            );
          }),
    );
  }
}
