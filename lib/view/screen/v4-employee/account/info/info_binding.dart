import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/account/info/info_controller.dart';

class V4InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4InfoController>(() => V4InfoController());
  }
}
