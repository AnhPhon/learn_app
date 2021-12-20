import 'package:get/get.dart';
import 'package:template/view/screen/my_order/detail_my_order/detail_my_order_controller.dart';

class DetailMyOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMyOrderController>(() => DetailMyOrderController());
  }
}
