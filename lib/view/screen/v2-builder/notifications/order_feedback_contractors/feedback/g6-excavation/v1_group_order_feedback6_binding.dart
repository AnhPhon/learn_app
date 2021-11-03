

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g6-excavation/v1_group_order_feedback6_controller.dart';

class V1OrderFeedBackGroup6Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1GroupOrderFeedBack6Controller>(() => V1GroupOrderFeedBack6Controller());
  }

}