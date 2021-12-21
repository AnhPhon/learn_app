import 'package:get/get.dart';
import 'package:template/view/screen/product_portfolio/product_portfolio_controller.dart';

class ProductPortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductPortfolioController>(() => ProductPortfolioController());
  }
}
