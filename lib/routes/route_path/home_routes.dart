import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/account/account_binding.dart';
import 'package:template/view/screen/account/account_page.dart';
import 'package:template/view/screen/dash_board/dash_board_binding.dart';
import 'package:template/view/screen/dash_board/dash_board_page.dart';
import 'package:template/view/screen/home/home_binding.dart';
import 'package:template/view/screen/home/home_page.dart';

class HomeRoutes {
    static const String HOME = '/home';
    static const String DASH_BOARD = '/dash_board';
    static const String ACCOUNT = '/account';

  static List<GetPage> list = [
    
    GetPage(
      name: DASH_BOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
  ];
}
