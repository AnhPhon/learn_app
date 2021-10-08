
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_list_controller.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/reviews/g7_review_controller.dart';

class V1G7PriceListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G7PriceListController>(() => V1G7PriceListController());
  }

}