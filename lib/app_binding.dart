import 'package:get/get.dart';
import 'package:template/view/screen/account/account_controller.dart';
import 'package:template/view/screen/auth/auth_controller.dart';
import 'package:template/view/screen/dashboard/dashboard_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/posts/posts_controller.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
