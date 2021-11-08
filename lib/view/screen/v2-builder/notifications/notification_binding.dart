

import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/notifications/notification_controller.dart';

class V2NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V2NotificationController>(() => V2NotificationController());
  }
}