import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/quote/no_response/no_response_controller.dart';

class V1NoResponseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1NoResponseController>(() => V1NoResponseController());
  }
}
