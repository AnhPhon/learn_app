import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class V3HomePage extends GetView<V3HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V3HomeController>(
          init: V3HomeController(),
          builder: (V3HomeController controller) {
            return const Center(
              child: Text("Home Page"),
            );
          }),
    );
  }

}
