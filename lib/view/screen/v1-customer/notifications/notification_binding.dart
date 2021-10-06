

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_controller.dart';

class V1NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1NotificationController>(() => V1NotificationController());
  }
}