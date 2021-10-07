import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/other_insurance/other_insurance_controller.dart';

class V1OtherInsurancePage extends GetView<V1OtherInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1OtherInsuranceController>(
        init: V1OtherInsuranceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
