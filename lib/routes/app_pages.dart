import 'package:get/get.dart';
import 'package:template/view/screen/account/rules/rules_page.dart';
import 'package:template/view/screen/auth/auth_page.dart';
import 'package:template/view/screen/categories/categories_page.dart';
import 'package:template/view/screen/categories/category_detail/category_detail_page.dart';
import 'package:template/view/screen/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/dashboard/dashboard_page.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/leaderboard/charts/charts_page.dart';
import 'package:template/view/screen/order/history/history_page.dart';
import 'package:template/view/screen/order/order_detail/order_detail_page.dart';
import 'package:template/view/screen/order/order_page.dart';
import 'package:template/view/screen/product_detail/product_detail_page.dart';
import 'package:template/view/screen/splash/splash_page.dart';

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
        name: AppRoutes.DASHBOARD,
        page: () => DashboardPage(),
        binding: DashboardBinding()),
    GetPage(
      name: AppRoutes.CATEGORIES,
      page: () => CategoriesPage(),
    ),
    GetPage(
      name: AppRoutes.CATEGORY_DETAIL,
      page: () => CategoryDetailPage(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.ORDER,
      page: () => OrderPage(),
    ),
    GetPage(
      name: AppRoutes.ORDER_DETAIL,
      page: () => OrderDetailPage(),
    ),
    GetPage(
      name: AppRoutes.HISTORY,
      page: () => HistoryPage(),
    ),
    GetPage(
      name: AppRoutes.RULES,
      page: () => RulesPage(),
    ),
    GetPage(
      name: AppRoutes.CHARTS,
      page: () => ChartsPage(),
    ),
    GetPage(
      name: AppRoutes.INTRO,
      page: () => IntroductionPage(),
    ),
  ];
}
