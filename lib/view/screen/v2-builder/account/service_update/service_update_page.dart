import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/account/service_update/service_update_controller.dart';

class V2ServiceUpdatePage extends GetView<V2ServiceUpdateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ServiceUpdateController>(
      init: V2ServiceUpdateController(),
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}
