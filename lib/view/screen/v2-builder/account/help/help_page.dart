import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/account/help/help_controller.dart';

class V2HelpPage extends GetView<V2HelpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2HelpController>(
        init: V2HelpController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
