import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/account/account_controller.dart';

class V2AccountPage extends GetView<V2AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V2AccountController>(
          init: V2AccountController(),
          builder: (V2AccountController controller) {
            return const Center(
              child: Text("Tài khoản"),
            );
          }),
    );
  }

}
