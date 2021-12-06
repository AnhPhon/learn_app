


import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/view/screen/splash/splash_page.dart';

class SplashRoutes {
  static const String SPLASH = '/splash';



  static List<GetPage> list = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
    ),
  ];

}
