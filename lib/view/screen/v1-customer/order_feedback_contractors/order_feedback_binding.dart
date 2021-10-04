

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/order_feedback_controller.dart';

class V1OrderFeedBackBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1OrderFeedBackController>(() => V1OrderFeedBackController());
  }

}