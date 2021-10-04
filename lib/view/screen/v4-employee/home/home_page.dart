import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class V4HomePage extends GetView<V4HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4HomeController>(
          init: V4HomeController(),
          builder: (V4HomeController controller) {
            return const Center(
              child: Text("Home Page"),
            );
          }),
    );
  }

}
