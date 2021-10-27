import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/notifications/detail_notification/detail_notification_controller.dart';

class V1DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1DetailNotificationController>(
        () => V1DetailNotificationController());
  }
}
