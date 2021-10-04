import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_controller.dart';
import 'package:template/view/screen/v1-customer/home/home_controller.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';
import 'package:template/view/screen/v1-customer/profile/profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<V1DashboardController>(() => V1DashboardController());
    Get.lazyPut<V1HomeController>(() => V1HomeController());
    Get.lazyPut<V1ProductController>(() => V1ProductController());
    Get.lazyPut<V1NewsController>(() => V1NewsController());
    Get.lazyPut<V1ProfileController>(() => V1ProfileController());
  }
}
