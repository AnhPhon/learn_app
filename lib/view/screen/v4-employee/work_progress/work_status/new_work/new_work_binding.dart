import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_status/new_work/new_work_controller.dart';

class V4DetailWorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4DetailWorkController>(() => V4DetailWorkController());
  }
}
