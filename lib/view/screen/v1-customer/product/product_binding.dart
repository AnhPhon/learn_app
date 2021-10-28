import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';

class V1ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1ProductController>(() => V1ProductController());
  }
}
