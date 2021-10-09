import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_controller.dart';

class V4RulesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      appBar: const AppBarWidget(title: "Điều khoản"),
      body: GetBuilder<V4RulesController>(
          init: V4RulesController(),
          builder: (V4RulesController controller) {
            return const Center(
              child: Text('Cung cấp nội dung sau'),
            );
          }),
    );
  }
}
