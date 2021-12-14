

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/view/screen/%1Daccount/account_controller.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';

class AccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}