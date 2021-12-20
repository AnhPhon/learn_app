import 'package:get/get.dart';
import 'package:template/view/screen/my_order/detail_my_order/detail_my_order_binding.dart';
import 'package:template/view/screen/my_order/detail_my_order/detail_my_order_page.dart';
import 'package:template/view/screen/my_order/my_order_binding.dart';
import 'package:template/view/screen/my_order/my_order_page.dart';

class MyOrderRouter {
  static const String MY_ORDER = "/my_order";
  static const String DETAIL_MY_ORDER = "/detail_my_order";
  static List<GetPage> myOrderList = [
    GetPage(
      name: MY_ORDER,
      page: () => MyOrderPage(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: DETAIL_MY_ORDER,
      page: () => DetailMyOrderPage(),
      binding: DetailMyOrderBinding(),
    ),
  ];
}
