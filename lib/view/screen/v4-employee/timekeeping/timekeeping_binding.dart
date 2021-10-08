import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_controller.dart';

class V4TimekeepingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4TimekeepingController>(() => V4TimekeepingController());
  }
}
