

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g1-build/v1_build_order_feedback_controller.dart';

class V1BuildOrderFeedBackBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1BuildOrderFeedBackController>(() => V1BuildOrderFeedBackController());
  }

}