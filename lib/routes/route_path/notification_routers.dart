import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_binding.dart';
import 'package:template/view/screen/notification/notification_detail/notification_detail_binding.dart';
import 'package:template/view/screen/notification/notification_detail/notification_detail_page.dart';
import 'package:template/view/screen/notification/notification_page.dart';

class NotificationRouters {
  static const NOTIFICATION = "/notification";
  static const NOTIFICATION_DETAIL = "/notification_detail";

  static List<GetPage> notificationList = [
    GetPage(
      name: NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: NOTIFICATION_DETAIL,
      page: () => NotificationDetailPage(),
      binding: NotificationDetailBinding(),
    ),
  ];
}
