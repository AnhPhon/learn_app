import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/account/account_controller.dart';

class V3AccountPage extends GetView<V3AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V3AccountController>(
          init: V3AccountController(),
          builder: (V3AccountController controller) {
            return const Center(
              child: Text("Account Page"),
            );
          }),
    );
  }

}
