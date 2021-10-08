import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/store/store_controller.dart';

class V3StorePage extends GetView<V3StoreController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3StoreController>(
        init: V3StoreController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
