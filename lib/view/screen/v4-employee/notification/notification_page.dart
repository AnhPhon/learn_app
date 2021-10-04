import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/notification/notification_controller.dart';

class V4NNotificationPage extends GetView<V4NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4NotificationController>(
          init: V4NotificationController(),
          builder: (V4NotificationController controller) {
            return const Center(
              child: Text("News Page"),
            );
          }),
    );
  }
}
