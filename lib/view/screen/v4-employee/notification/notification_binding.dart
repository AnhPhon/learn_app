import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/notification/notification_controller.dart';

class V4NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4NotificationController>(() => V4NotificationController());
  }
}
