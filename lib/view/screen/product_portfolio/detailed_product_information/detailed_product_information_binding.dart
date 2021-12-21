import 'package:get/get.dart';
import 'package:template/view/screen/product_portfolio/detailed_product_information/detailed_product_information_controller.dart';

class DetailedProductInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedProductInformationController>(() => DetailedProductInformationController());
  }
}
