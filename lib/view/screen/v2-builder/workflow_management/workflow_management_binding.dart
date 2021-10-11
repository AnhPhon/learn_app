import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/workflow_management/workflow_management_controller.dart';

class V2WorkflowManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkflowManagementController>(
        () => V2WorkflowManagementController());
  }
}
