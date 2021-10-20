import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/view/screen/v1-customer/account/account_controller.dart';
import 'package:template/view/screen/v1-customer/entertainment/entertainment_controller.dart';
import 'package:template/view/screen/v1-customer/home/home_controller.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';
import 'package:template/view/screen/v1-customer/project/project_controller.dart';

class V1DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1HomeController>(() => V1HomeController());
    Get.lazyPut<V1ProjectController>(() => V1ProjectController());
    Get.lazyPut<V1EntertainmentController>(() => V1EntertainmentController());
    Get.lazyPut<V1NewsController>(() => V1NewsController());
    Get.lazyPut<V1AccountController>(() => V1AccountController());
    Get.lazyPut<V1ProductController>(() => V1ProductController());
    Get.lazyPut<RefreshController>(() => RefreshController());
  }
}
