import 'package:get/get.dart';
import 'package:template/view/screen/auth/auth_page.dart';
import 'package:template/view/screen/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/dashboard/dashboard_page.dart';
import 'package:template/view/screen/splash/splash_page.dart';
import 'package:template/view/screen/login/login_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding()
    ),
  ];
}
