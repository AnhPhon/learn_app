import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/account_management_routers.dart';
import 'package:template/routes/route_path/demo_base_card_routers.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:template/routes/route_path/my_order_routes.dart';
import 'package:template/routes/route_path/refer_friends_routers.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/routes/route_path/voucher_routers.dart';

class AppPages {
  static List<GetPage> list = [
    ...SplashRoutes.list,
    ...MyOrderRouter.myOrderList,
    ...DemoBaseCardRouter.demoBaseCardList,
    ...AccountManagementRouter.accountManagementList,
    ...VoucherRouters.voucherList,
    ...ReferFriendsRouters.referFriendsList,
  ];
}
