import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/account/account_controller.dart';
import 'package:template/view/screen/v3-agent/entertainment/entertainment_controller.dart';
import 'package:template/view/screen/v3-agent/home/home_controller.dart';
import 'package:template/view/screen/v3-agent/news/news_controller.dart';
import 'package:template/view/screen/v3-agent/project/project_controller.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3HomeController>(() => V3HomeController());
    Get.lazyPut<V3ProjectController>(() => V3ProjectController());
    Get.lazyPut<V3EntertainmentController>(() => V3EntertainmentController());
    Get.lazyPut<V3NewsController>(() => V3NewsController());
    Get.lazyPut<V3AccountController>(() => V3AccountController());
    Get.lazyPut<V3QuoteListController>(() => V3QuoteListController());
  }
}
