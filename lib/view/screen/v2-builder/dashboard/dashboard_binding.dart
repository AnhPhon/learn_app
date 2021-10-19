import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/view/screen/v2-builder/account/account_controller.dart';
import 'package:template/view/screen/v2-builder/entertainment/entertainment_controller.dart';
import 'package:template/view/screen/v2-builder/home/home_controller.dart';
import 'package:template/view/screen/v2-builder/news/news_controller.dart';
import 'package:template/view/screen/v2-builder/product/product_controller.dart';
import 'package:template/view/screen/v2-builder/project/project_controller.dart';

class V2DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2HomeController>(() => V2HomeController());
    Get.lazyPut<V2ProjectController>(() => V2ProjectController());
    Get.lazyPut<V2EntertainmentController>(() => V2EntertainmentController());
    Get.lazyPut<V2NewsController>(() => V2NewsController());
    Get.lazyPut<V2AccountController>(() => V2AccountController());
    Get.lazyPut<V2ProductController>(() => V2ProductController());
    Get.lazyPut<RefreshController>(() => RefreshController());
  }
}
