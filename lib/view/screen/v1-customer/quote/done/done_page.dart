import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/quote/done/done_controller.dart';

class V1Request1Page extends GetView<V1DoneController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1DoneController>(
      init: V1DoneController(),
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
