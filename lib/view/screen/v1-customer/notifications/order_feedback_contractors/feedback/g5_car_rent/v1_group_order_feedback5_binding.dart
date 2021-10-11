

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g5_car_rent/v1_group_order_feedback5_controller.dart';

class V1OrderFeedBackGroup5Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1GroupOrderFeedBack5Controller>(() => V1GroupOrderFeedBack5Controller());
  }

}