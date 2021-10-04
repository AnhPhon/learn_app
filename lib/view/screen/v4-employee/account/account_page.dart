import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/account/account_controller.dart';

class V4AccountPage extends GetView<V4AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4AccountController>(
          init: V4AccountController(),
          builder: (V4AccountController controller) {
            return const Center(
              child: Text("Home Page"),
            );
          }),
    );
  }

}
