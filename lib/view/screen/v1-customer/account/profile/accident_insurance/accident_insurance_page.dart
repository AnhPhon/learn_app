import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/accident_insurance/accident_insurance_controller.dart';

class V1AccidentInsurancePage extends GetView<V1AccidentInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1AccidentInsuranceController>(
        init: V1AccidentInsuranceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
