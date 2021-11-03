import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/quote/response/response_controller.dart';

class V1ResponseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1ResponseController>(() => V1ResponseController());
  }
}
