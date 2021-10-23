import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin/order_information_controller.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin_feedback/order_information_controller.dart';

class OrderFeedbackInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderFeedbackInformationController>(() => OrderFeedbackInformationController());
  }

}