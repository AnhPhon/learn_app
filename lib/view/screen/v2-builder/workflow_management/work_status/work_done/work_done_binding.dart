import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/work_done_controller.dart';

class V2WorkDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkDoneController>(() => V2WorkDoneController());
  }
}
