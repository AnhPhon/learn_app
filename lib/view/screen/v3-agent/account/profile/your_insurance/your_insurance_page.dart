import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/your_insurance/your_insurance_controller.dart';
import 'package:template/view/screen/v3-agent/component_customer/item_list_widget.dart';

class V3YourInsurancePage extends GetView<V3YourInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3YourInsuranceController>(
        init: V3YourInsuranceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: ItemListWidget(
              onTap: () {},
              title: "Bảo hiểm ô tô bắt buộc",
              rowText1: "7.500.000 vnđ",
              colorRowText1: ColorResources.RED,
              rowText2: "Ngày hết hạn: 20/09/2021",
              isSpaceBetween: true,
            ),
          );
        });
  }
}
