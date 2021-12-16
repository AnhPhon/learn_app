import 'package:get/get.dart';
import 'package:template/view/screen/account/account_controller.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}