import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_controller.dart';

class V4RulesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      appBar: const AppBarWidget(title: "Nội quy, quy chế"),
      body: GetBuilder<V4RulesController>(
          init: V4RulesController(),
          builder: (V4RulesController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dieuKhoanChinhSachModelList[0].tieuDe
                            .toString(),
                        style: Dimensions.fontSizeStyle20w600(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Text(
                    controller.dieuKhoanChinhSachModelList[0].noiDung
                        .toString(),
                    style: Dimensions.fontSizeStyle16(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
