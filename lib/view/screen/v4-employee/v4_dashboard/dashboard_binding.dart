import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/account/account_controller.dart';
import 'package:template/view/screen/v4-employee/home/home_controller.dart';
import 'package:template/view/screen/v4-employee/news/news_controller.dart';
import 'package:template/view/screen/v4-employee/notification/notification_controller.dart';
import 'package:template/view/screen/v4-employee/report/report_controller.dart'; 

class V4DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4HomeController>(() => V4HomeController());
    Get.lazyPut<V4NotificationController>(() => V4NotificationController());
    Get.lazyPut<V4NewsController>(() => V4NewsController());
    Get.lazyPut<V4ReportController>(() => V4ReportController());
    Get.lazyPut<V4AccountController>(() => V4AccountController());
  }
}
