import 'package:get/get.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v1-customer/drawer/Benefits.dart';
import 'package:template/view/screen/v1-customer/drawer/about_page.dart';
import 'package:template/view/screen/v1-customer/drawer/rights_and_obligations.dart';
import 'package:template/view/screen/v1-customer/drawer/terms_and_policy.dart';
import 'package:template/view/screen/v1-customer/drawer/usage_procedure.dart';
import 'package:template/view/screen/v1-customer/form_management/bill_detail/bill_detail_page.dart';
import 'package:template/view/screen/v1-customer/form_management/form_list/form_list_page.dart';
import 'package:template/view/screen/v1-customer/form_management/form_management_page.dart';
import 'package:template/view/screen/v1-customer/form_management/job_detail/job_detail_page.dart';
import 'package:template/view/screen/v1-customer/form_management/payment_method/payment_method_page.dart';
import 'package:template/view/screen/v1-customer/form_management/product_response/product_response_page.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';
import 'package:template/view/screen/v1-customer/news/news_page.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_page.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/bulletin/order_information_binding.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/bulletin/order_information_page.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/building_materials/order_feedback_binding.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/building_materials/order_feedback_page.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-5/v1_group_order_feedback5_binding.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-5/v1_group_order_feedback5_page.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-6/v1_group_order_feedback6_binding.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/group-6/v1_group_order_feedback6_page.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_page.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_page.dart';
import 'package:template/view/screen/v1-customer/product/product_page.dart';
import 'package:template/view/screen/v1-customer/profile/profile_page.dart';
import 'package:template/view/screen/v1-customer/services/create_work_page.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/g1_create_work_binding.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/g1_create_work_page.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_page.dart';
import 'package:get/get.dart';
// import 'package:template/view/screen/auth/auth_page.dart';
// import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/v4-employee/notification/notification_binding.dart';
import 'package:template/view/screen/v4-employee/notification/notification_page.dart';
// import 'package:template/view/screen/splash/splash_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),

    // custommer
    GetPage(
      name: AppRoutes.V1_DASHBOARD,
      page: () => V1DashboardPage(),
      binding: V1DashboardBinding(),
    ),

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
    GetPage(
      name: AppRoutes.V1_PAYMENT_METHOD,
      page: () => V1PaymentMethodPage(),
    ),
    GetPage(
      name: AppRoutes.V1_HOME,
      page: () => V1HomePage(),
    ),
    GetPage(
      name: AppRoutes.V1_PRODUCT,
      page: () => V1ProductPage(),
    ),
    GetPage(
      name: AppRoutes.V1_NEWS,
      page: () => V1NewsPage(),
    ),
    GetPage(
      name: AppRoutes.V1_PROFILE,
      page: () => V1ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.V1_FORM_MANAGEMENT,
      page: () => V1FormManagementPage(),
    ),
    GetPage(
      name: AppRoutes.V1_PRODUCT_RESPONSE,
      page: () => V1ProductResponsePage(),
    ),
    GetPage(
      name: AppRoutes.V1_BILL_DETAIL,
      page: () => V1BillDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V1_JOB_DETAIL,
      page: () => V1JobDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V1_FORM_LIST,
      page: () => V1FormListPage(),
    ),
    GetPage(
      name: AppRoutes.V1_PRODUCT_DETAIL,
      page: () => V1ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V1_CART,
      page: () => V1CartPage(),
    ),

    ///
    /// Thông báo
    ///
    GetPage(
      name: AppRoutes.V1NOTIFICATION,
      page: () => V1NotificationPage(),
      binding: V1NotificationBinding(),
    ),

    ///
    /// Phản hồi dịch vụ thường xuyên click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1ORDERFEEDBACKCONTRACTORS,
      page: () => V1OrderFeedBackPage(),
      binding: V1OrderFeedBackBinding(),
    ),

    ///
    /// Phản hồi đơn hàng nhóm 5 click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1_GROUPORDERFEEDBACK5,
      page: () => const V1GroupOrderFeedBack5Page(),
      binding: V1OrderFeedBackGroup5Binding(),
    ),

    ///
    /// Phản hồi đơn hàng nhóm 6 click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1_GROUPORDERFEEDBACK6,
      page: () => const V1GroupOrderFeedBack6Page(),
      binding: V1OrderFeedBackGroup6Binding(),
    ),

    ///
    /// Thông tin đơn hàng
    ///
    GetPage(
      name: AppRoutes.V1_ORDERINFORAMTION, 
      page: ()=> OrderInformationPage(),
      binding: OrderInformationBinding(),
    ),

    ///
    ///Tạo đơn công việc 1- 6
    ///
    GetPage(
      name: AppRoutes.V1_CREATEWORK, 
      page: ()=> CreateWorkPage(),
    ),
    // Nhóm 1
    GetPage(
      name: AppRoutes.V1_G1CREATEWORK, 
      page: ()=> V1G1CreateWorkPage(),
      binding: V1G1CreateWorkBinding()
    ),

    GetPage(
      name: AppRoutes.V1_DASHBOARD,
      page: () => V1DashboardPage(),
      binding: V1DashboardBinding(),
    ),

    // builder
    GetPage(
      name: AppRoutes.V2_DASHBOARD,
      page: () => V2DashboardPage(),
      binding: V2DashboardBinding(),
    ),

    // agent
    GetPage(
      name: AppRoutes.V3_DASHBOARD,
      page: () => V3DashboardPage(),
      binding: V3DashboardBinding(),
    ),

    // v4 - employee
    GetPage(
      name: AppRoutes.V4_DASHBOARD,
      page: () => V4DashboardPage(),
      binding: V4DashboardBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.INTRO,
    //   page: () => IntroductionPage(),
    // ),
  ];
}
