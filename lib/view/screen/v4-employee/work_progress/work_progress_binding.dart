import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'package:template/view/screen/v4-employee/work_progress/work_progress_controller.dart';

class V4WorkProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4WorkProgressController>(() => V4WorkProgressController());
  }
}
