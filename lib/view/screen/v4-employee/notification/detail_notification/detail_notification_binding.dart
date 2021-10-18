import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/notification/detail_notification/detail_notification_controller.dart';

class V4DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4DetailNotificationController>(
        () => V4DetailNotificationController());
  }
}
