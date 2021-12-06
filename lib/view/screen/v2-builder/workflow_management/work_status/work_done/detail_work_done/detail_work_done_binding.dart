import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/detail_work_done/detail_work_done_controller.dart';

class V2DetailWorkDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2DetailWorkDoneController>(() => V2DetailWorkDoneController());
  }
}
