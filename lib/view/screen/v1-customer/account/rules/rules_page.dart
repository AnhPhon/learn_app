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
                  Image.asset("assets/images/device.png"),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: Text(
                      "THIẾT BỊ",
                      style: Dimensions.fontSizeStyle20w600(),
                    ),
                  ),
                  Text(
                    "Bất kỳ thiết bị, hệ thống hoặc tiện ích nào, do Công ty hoặc các nhà thầu phụ của Công ty cung cấp có thể được sử dụng trực tiếp hoặc gián tiếp trong việc cung cấp Dịch vụ, và không phải là đối tượng của một thỏa thuận riêng giữa các Bên theo đó quyền sở hữu được chuyển sang Khách hàng.",
                    textAlign: TextAlign.center,
                    style: Dimensions.fontSizeStyle16()
                        .copyWith(color: ColorResources.GREY),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
