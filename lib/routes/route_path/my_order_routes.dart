import 'package:get/get.dart';
import 'package:template/view/screen/mock/my_order/my_order_page.dart';

class MyOrderRouter {
  static const String MY_ORDER = "/my_order";
  static List<GetPage> myOrderList = [
    GetPage(
      name: MY_ORDER,
      page: () => MyOrderPage(),
    ),
  ];
}
