import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/detail_notification/detail_notification_controller.dart';
import 'package:template/view/screen/v2-builder/notifications/detail_notification/detail_notification_controller.dart';

class V2DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2DetailNotificationController>(
        () => V2DetailNotificationController());
  }
}
