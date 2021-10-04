

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}