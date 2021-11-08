import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/account/product_update/product_update_controller.dart';

class V2ProductUpdatePage extends GetView<V2ProductUpdateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProductUpdateController>(
      init: V2ProductUpdateController(),
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}
