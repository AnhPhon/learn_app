import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/product_add/product_add_controller.dart';

class V3ProductAddPage extends GetView<V3ProductAddController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProductAddController>(
        init: V3ProductAddController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
