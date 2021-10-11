import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_controller.dart';

class V4AddDailyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4AddDailyReportController>(() => V4AddDailyReportController());
  }
}
