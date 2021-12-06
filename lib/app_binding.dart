import 'package:get/get.dart';
import 'package:template/view/screen/product/product_controller.dart';
import 'package:template/view/screen/v1-customer/account/account_controller.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_controller.dart';
import 'package:template/view/screen/v1-customer/home/home_controller.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';
// import 'package:template/view/screen/auth/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1DashboardController>(() => V1DashboardController());
    Get.lazyPut<V1HomeController>(() => V1HomeController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<V1NewsController>(() => V1NewsController());
    Get.lazyPut<V1AccountController>(() => V1AccountController());
    Get.lazyPut<ProductController>(() => ProductController());
    // Get.lazyPut<AuthController>(() => AuthController());
  }
}
