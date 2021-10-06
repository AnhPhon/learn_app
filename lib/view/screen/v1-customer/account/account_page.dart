import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/account/account_controller.dart';

class V1AccountPage extends GetView<V1AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V1AccountController>(
          init: V1AccountController(),
          builder: (V1AccountController controller) {
            return const Center(
              child: Text("Tài khoản"),
            );
          }),
    );
  }

}
