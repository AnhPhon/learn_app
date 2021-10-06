
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/formal_payment/formal_payment_controller.dart';

class V1FormalPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1FormalPaymentController>(() => V1FormalPaymentController());
  }

}