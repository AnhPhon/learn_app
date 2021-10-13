import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/screen/v4-employee/notification/detail_notification/detail_notification_controller.dart';

class V4DetailNotificationPage extends GetView<V4DetailNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Chi tiết thông báo",
      ),
      body: GetBuilder<V4DetailNotificationController>(
          init: V4DetailNotificationController(),
          builder: (V4DetailNotificationController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Text(
                  controller.thongBaoModel.idDuAnNhanVien!.tieuDe.toString(),
                ),
              ],
            );
          }),
    );
  }
}
