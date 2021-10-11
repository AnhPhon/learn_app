import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/insurance_detail/insurance_detail_controller.dart';

class V3InsuranceDetailPage extends GetView<V3InsuranceDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3InsuranceDetailController>(
        init: V3InsuranceDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
