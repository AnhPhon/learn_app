

import 'package:get/get.dart';
import 'package:template/view/screen/Product/Product_controller.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}