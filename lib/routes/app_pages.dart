import 'package:get/get.dart';
import 'package:template/view/screen/account/rules/rules_page.dart';
import 'package:template/view/screen/address/address_page.dart';
import 'package:template/view/screen/auth/auth_page.dart';
import 'package:template/view/screen/cart/cart_page.dart';
import 'package:template/view/screen/categories/categories_page.dart';
import 'package:template/view/screen/checkout/checkout_page.dart';
import 'package:template/view/screen/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/dashboard/dashboard_page.dart';
import 'package:template/view/screen/group/group_page.dart';
import 'package:template/view/screen/home/kho_hang_dieu_kien/kho_hang_dieu_kien_page.dart';
import 'package:template/view/screen/home/kho_hang_tro_gia/kho_hang_tro_gia_page.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/leaderboard/charts/charts_page.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/news/news_detail/news_detail_page.dart';
import 'package:template/view/screen/order/history/history_page.dart';
import 'package:template/view/screen/order/order_detail/order_detail_page.dart';
import 'package:template/view/screen/order/order_page.dart';
import 'package:template/view/screen/product_detail/product_detail_page.dart';
import 'package:template/view/screen/register/register_page.dart';
import 'package:template/view/screen/register/register_page_2.dart';
import 'package:template/view/screen/register/register_page_3.dart';
import 'package:template/view/screen/register/register_page_4.dart';
import 'package:template/view/screen/splash/splash_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
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
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_PAGE_2,
      page: () => RegisterPage2(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_PAGE_3,
      page: () => RegisterPage3(),
    ),
    GetPage(
      name: AppRoutes.REGISTER_PAGE_4,
      page: () => RegisterPage4(),
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
      name: AppRoutes.KHOHANGDIEUKIEN,
      page: () => KhoHangDieuKienPage(),
    ),
    GetPage(
      name: AppRoutes.KHOHANGTROGIA,
      page: () => KhoHangTroGiaPage(),
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
    GetPage(
      name: AppRoutes.NEWS_DETAIL,
      page: () => NewsDetailPage(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartPage(),
    ),
    GetPage(
      name: AppRoutes.GROUP,
      page: () => GroupPage(),
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: AppRoutes.ADDRESS,
      page: () => AddressPage(),
    ),
  ];
}
