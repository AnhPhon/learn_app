import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v2-builder/account/rules/rules_controller.dart';

class V2RulesPage extends GetView<V2RulesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2RulesController>(
      init: V2RulesController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: ColorResources.WHITE,
          appBar: AppBarWidget(title: controller.title),
          body: controller.dieuKhoanChinhSachResponse == null
              ? const Center(
                  child: Text("Chưa có điều khoản để hiển thị"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      Image.asset(
                        Images.logo_fss,
                        width: DeviceUtils.getScaledWidth(context, .4),
                      ),
                      Specification(
                        specification:
                            controller.dieuKhoanChinhSachResponse!.noiDung!,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
