import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/work_done_controller.dart';

class V2WorkInDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkInDoneController>(() => V2WorkInDoneController());
  }
}
