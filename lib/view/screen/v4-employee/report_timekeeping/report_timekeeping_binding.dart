import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_controller.dart';

class V4ReportTimekeepingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4ReportTimekeepingControllter>(
        () => V4ReportTimekeepingControllter());
  }
}
