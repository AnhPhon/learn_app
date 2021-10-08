import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/report/report_controller.dart';

class V4ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4ReportController>(() => V4ReportController());
  }
}
