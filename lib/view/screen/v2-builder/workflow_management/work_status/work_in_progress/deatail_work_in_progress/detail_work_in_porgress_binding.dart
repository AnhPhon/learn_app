import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/deatail_work_in_progress/detail_work_in_porgress_controller.dart';

class V2DetailWorkInProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2DetailWorkInProgressController>(
        () => V2DetailWorkInProgressController());
  }
}
