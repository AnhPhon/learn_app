

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}