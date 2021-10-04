import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/account/account_controller.dart';
import 'package:template/view/screen/v2-builder/entertainment/entertainment_controller.dart';
import 'package:template/view/screen/v2-builder/home/home_controller.dart';
import 'package:template/view/screen/v2-builder/news/news_controller.dart';
import 'package:template/view/screen/v2-builder/project/home_controller.dart';

class V4DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2HomeController>(() => V2HomeController());
    Get.lazyPut<V2ProjectController>(() => V2ProjectController());
    Get.lazyPut<V2EntertainmentController>(() => V2EntertainmentController());
    Get.lazyPut<V2NewsController>(() => V2NewsController());
    Get.lazyPut<V2AccountController>(() => V2AccountController());
  }
}
