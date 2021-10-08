import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/quote/check/check_controller.dart';

class V1CheckPage extends GetView<V1CheckController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1CheckController>(
      init: V1CheckController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        );
      },
    );
  }
}
