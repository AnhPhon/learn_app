import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/report/detail_report/detail_report_controller.dart';

class V4DetailReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4DetailReportController>(
            () => V4DetailReportController());
  }
}
