import 'package:get/get.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/v4-employee/v4_dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/v4_dashboard/dashboard_page.dart';
import 'package:template/view/screen/v1-customer/drawer/about_page.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    // custommer
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),

    /// About
    GetPage(
      name: AppRoutes.V1ABOUT,
      page: () => AboutPage(),
    ),

    // builder

    // agent

    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),

    // v4 - employee
    GetPage(
      name: AppRoutes.V4_DASHBOARD,
      page: () => V4DashboardPage(),
      binding: V4DashboardBinding(),
    ),
    
  ];
}
