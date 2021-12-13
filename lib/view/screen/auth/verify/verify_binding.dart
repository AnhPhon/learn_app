

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/view/screen/auth/verify/verify_controller.dart';

class VerifyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}