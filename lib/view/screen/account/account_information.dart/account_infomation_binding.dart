

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/view/screen/%1Daccount/account_information.dart/account_information_controller.dart';

class AccountInfomationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AccountInfomationController>(() => AccountInfomationController());
  }
}