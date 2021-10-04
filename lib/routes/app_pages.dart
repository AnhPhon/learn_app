import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v1-customer/drawer/Benefits.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/v1-customer/drawer/about_page.dart';
import 'package:template/view/screen/v1-customer/drawer/rights_and_obligations.dart';
import 'package:template/view/screen/v1-customer/drawer/terms_and_policy.dart';
import 'package:template/view/screen/v1-customer/drawer/usage_procedure.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_page.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/order_feedback_binding.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/order_feedback_page.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    /// About
    GetPage(
      name: AppRoutes.V1ABOUT,
      page: () => AboutPage(),
    ),
    GetPage(
      name: AppRoutes.V1BENEFITS,
      page: () => Benefits(),
    ),
    GetPage(
      name: AppRoutes.V1TERMANDPOLICY,
      page: () => TermsAndPolicy(),
    ),
    GetPage(
      name: AppRoutes.V1USAGEPROCEDURE,
      page: () => UsageProcedure(),
    ),
    GetPage(
      name: AppRoutes.V1OBLIGATIONS,
      page: () => RightsAndObligations(),
    ),

    ///
    /// Thông báo
    ///
    GetPage(
        name: AppRoutes.V1NOTIFICATION,
        page: () => V1NotificationPage(),
        binding: V1NotificationBinding()),
    ///
    /// Phản hồi dịch vụ thường xuyên click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1ORDERFEEDBACKCONTRACTORS,
      page: () => V1OrderFeedBackPage(),
      binding: V1OrderFeedBackBinding(),
    ),
    GetPage(
      name: AppRoutes.V1_DASHBOARD,
      page: () => V1DashboardPage(),
    ),

    // builder
    GetPage(
      name: AppRoutes.V2_DASHBOARD,
      page: () => V2DashboardPage(),
    ),

    // agent
    GetPage(
      name: AppRoutes.V3_DASHBOARD,
      page: () => V3DashboardPage(),
    ),

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
