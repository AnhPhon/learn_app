import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    // final AuthController _controller = Get.find();

    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text("Counter ${controller.counter.value}")),
              MaterialButton(
                onPressed: () => controller.increaseCounter(),
                child: const Text("Increase"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
