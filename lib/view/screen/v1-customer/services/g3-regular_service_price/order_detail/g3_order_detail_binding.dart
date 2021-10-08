import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_detail/g3_order_detail_controller.dart';

class V1G3OrderDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G3OrderDetailController>(() => V1G3OrderDetailController());
  }

}