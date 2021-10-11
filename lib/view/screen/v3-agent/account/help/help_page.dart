import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/help/help_controller.dart';

class V3HelpPage extends GetView<V3HelpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3HelpController>(
        init: V3HelpController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
