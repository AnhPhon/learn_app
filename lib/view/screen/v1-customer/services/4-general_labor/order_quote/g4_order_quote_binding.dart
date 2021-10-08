import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_controller.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_quote/g3_order_quote_controller.dart';

class V1G4OrderQuoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G4OrderQuoteController>(() => V1G4OrderQuoteController());
  }

}