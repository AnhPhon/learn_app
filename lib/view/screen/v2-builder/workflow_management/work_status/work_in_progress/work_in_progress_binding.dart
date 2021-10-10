import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/work_in_progress_controller.dart';

class V2WorkInProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkInProgressController>(() => V2WorkInProgressController());
  }
}
