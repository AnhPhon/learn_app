import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/project/project_controller.dart';

class V1ProjectPage extends GetView<V1ProjectController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProjectController>(
        init: V1ProjectController(),
        builder: (controller) {
          return const Center(child: Text("Dự án"));
        });
  }
}
