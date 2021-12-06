import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v2-builder/account/safety/safety_controller.dart';

class V2SafetyPage extends GetView<V2SafetyController> {
@override
  Widget build(BuildContext context) {
    return GetBuilder<V2SafetyController>(
        init: V2SafetyController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  Specification(
                    specification:
                        controller.thongTinFSSResponse.huongDanAnToanLaoDong.toString(),
                  ),
                ],
              ),
            ),
          );
        },);
  }
}
