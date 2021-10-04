import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/project/project_controller.dart';

class V3ProjectPage extends GetView<V3ProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V3ProjectController>(
          init: V3ProjectController(),
          builder: (V3ProjectController controller) {
            return const Center(
              child: Text("Report Page"),
            );
          }),
    );
  }
}
