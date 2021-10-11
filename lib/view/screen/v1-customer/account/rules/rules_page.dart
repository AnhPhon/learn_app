import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/rules/rules_controller.dart';

class V1RulesPage extends GetView<V1RulesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1RulesController>(
        init: V1RulesController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                children: [
                  //title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      controller.title,
                      style: Dimensions.fontSizeStyle22w600(),
                    ),
                  ),

                  //subtitle
                  Text(
                    controller.subTitle,
                    textAlign: TextAlign.justify,
                    style: Dimensions.fontSizeStyle16().copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
