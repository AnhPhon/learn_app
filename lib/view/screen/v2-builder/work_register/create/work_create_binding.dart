import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/work_register/create/work_create_controller.dart';

class V2WorkCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkCreateController>(() => V2WorkCreateController());
  }
}
