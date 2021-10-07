import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/introduce/introduce_controller.dart';

class V1IntroducePage extends GetView<V1IntroduceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1IntroduceController>(
        init: V1IntroduceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
