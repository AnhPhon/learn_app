import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/notifications/detail_notification/detail_notification_controller.dart';

class V3DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3DetailNotificationController>(
        () => V3DetailNotificationController());
  }
}
