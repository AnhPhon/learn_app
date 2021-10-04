import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/account/account_controller.dart';
import 'package:template/view/screen/v1-customer/entertainment/entertainment_controller.dart';
import 'package:template/view/screen/v1-customer/home/home_controller.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';
import 'package:template/view/screen/v1-customer/project/home_controller.dart';

class V4DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1HomeController>(() => V1HomeController());
    Get.lazyPut<V1ProjectController>(() => V1ProjectController());
    Get.lazyPut<V1EntertainmentController>(() => V1EntertainmentController());
    Get.lazyPut<V1NewsController>(() => V1NewsController());
    Get.lazyPut<V1AccountController>(() => V1AccountController());
  }
}
