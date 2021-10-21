import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/rules/rules_controller.dart';
import 'package:template/view/screen/v1-customer/account/rules/rules_specification.dart';

class V1RulesPage extends GetView<V1RulesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1RulesController>(
        init: V1RulesController(),
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
                        //title
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_LARGE,
                            vertical: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: Text(
                            controller.dieuKhoanChinhSachResponse!.tieuDe!,
                            style: Dimensions.fontSizeStyle22w600(),
                          ),
                        ),

                        //subtitle
                        RulesSpecification(
                          rulesSpecification:
                              controller.dieuKhoanChinhSachResponse!.noiDung!,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
