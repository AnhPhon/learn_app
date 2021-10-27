import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/screen/v2-builder/account/profile/your_insurance/your_insurance_controller.dart';

class V2YourInsurancePage extends GetView<V2YourInsuranceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2YourInsuranceController>(
        init: V2YourInsuranceController(),
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
              urlImage: '',
            ),
          );
        });
  }
}
