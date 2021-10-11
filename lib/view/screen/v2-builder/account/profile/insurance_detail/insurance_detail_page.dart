import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/account/profile/insurance_detail/insurance_detail_controller.dart';

class V2InsuranceDetailPage extends GetView<V2InsuranceDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2InsuranceDetailController>(
        init: V2InsuranceDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
