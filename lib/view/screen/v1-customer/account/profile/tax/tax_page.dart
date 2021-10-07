import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/tax/tax_controller.dart';

class V1TaxPage extends GetView<V1TaxController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1TaxController>(
        init: V1TaxController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
