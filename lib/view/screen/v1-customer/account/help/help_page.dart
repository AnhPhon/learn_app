import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/help/help_controller.dart';

class V1HelpPage extends GetView<V1HelpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1HelpController>(
        init: V1HelpController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
