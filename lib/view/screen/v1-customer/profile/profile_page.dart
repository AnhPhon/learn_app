import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/profile/profile_controller.dart';

class V1ProfilePage extends GetView<V1ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProfileController>(
        init: V1ProfileController(),
        builder: (controller) {
          return const Center(child: Text("Tài khoản"));
        });
  }
}
