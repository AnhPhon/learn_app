

import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/notifications/notification_controller.dart';

class V3NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V3NotificationController>(() => V3NotificationController());
  }
}