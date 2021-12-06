import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin/order_information_controller.dart';

class OrderInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1OrderInformationController>(
        () => V1OrderInformationController());
  }
}
