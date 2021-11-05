import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/account/revenue/revenue_controller.dart';

class V2RevenuePage extends GetView<V2RevenueController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2RevenueController>(
      init: V2RevenueController(),
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}
