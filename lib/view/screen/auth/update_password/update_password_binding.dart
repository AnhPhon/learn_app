

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/view/screen/auth/update_password/update_password_controller.dart';

class UpdatePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(() => UpdatePasswordController());
  }
}