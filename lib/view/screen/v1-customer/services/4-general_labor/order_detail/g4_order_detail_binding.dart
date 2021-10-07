import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_detail/g4_order_detail_controller.dart';

class V1G4OrderDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G4OrderDetailController>(() => V1G4OrderDetailController());
  }

}