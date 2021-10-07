import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/contract/contract_controller.dart';

class V1ContractPage extends GetView<V1ContractController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ContractController>(
        init: V1ContractController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
