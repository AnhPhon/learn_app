import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_controller.dart';

class V4AddReportOnRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4AddReportOnRequestController>(
        () => V4AddReportOnRequestController());
  }
}
