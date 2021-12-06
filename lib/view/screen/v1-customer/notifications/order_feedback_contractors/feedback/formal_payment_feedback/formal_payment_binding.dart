
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/formal_payment_feedback/formal_payment_controller.dart';

class V1FormalPaymentFeedbackBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1FormalPaymentFeedbackController>(() => V1FormalPaymentFeedbackController());
  }

}