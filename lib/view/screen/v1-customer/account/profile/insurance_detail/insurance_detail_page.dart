import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_detail/insurance_detail_controller.dart';

class V1InsuranceDetailPage extends GetView<V1InsuranceDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1InsuranceDetailController>(
        init: V1InsuranceDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
