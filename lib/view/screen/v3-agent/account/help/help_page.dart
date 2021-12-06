import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v3-agent/account/help/help_controller.dart';

class V3HelpPage extends GetView<V3HelpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3HelpController>(
      init: V3HelpController(),
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
                      controller.thongTinFSSResponse.hoTro.toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
