import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/screen/v1-customer/quote/response/response_controller.dart';

class V1ResponsePage extends GetView<V1ResponseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ResponseController>(
      init: V1ResponseController(),
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
