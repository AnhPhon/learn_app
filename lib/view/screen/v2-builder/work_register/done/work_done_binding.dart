import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/work_register/done/work_done_controller.dart';

class V2RegisterDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2RegisterDoneController>(() => V2RegisterDoneController());
  }
}
