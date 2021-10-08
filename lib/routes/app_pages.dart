import 'package:get/get.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/v1-customer/account/help/help_page.dart';
import 'package:template/view/screen/v1-customer/account/introduce/introduce_page.dart';
import 'package:template/view/screen/v1-customer/account/job_management/job_management_page.dart';
import 'package:template/view/screen/v1-customer/account/point_based/point_based_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/accident_insurance/accident_insurance_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/contract/contract_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_detail/insurance_detail_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_register/insurance_register_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/other_insurance/other_insurance_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/profile_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/tax/tax_page.dart';
import 'package:template/view/screen/v1-customer/account/profile/your_insurance/your_insurance_page.dart';
import 'package:template/view/screen/v1-customer/account/rules/rules_page.dart';
import 'package:template/view/screen/v1-customer/account/wallet/wallet_page.dart';
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
import 'package:template/view/screen/v1-customer/payment%20account/payment_account_page.dart';
import 'package:template/view/screen/v1-customer/payment_success/payment_success_page.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_page.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_page.dart';
import 'package:template/view/screen/v1-customer/product/product_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_address/shipping_address_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_method/shipping_method_page.dart';
import 'package:template/view/screen/v1-customer/recharge/recharge_page.dart';
import 'package:template/view/screen/v1-customer/services/create_work_page.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/g1_create_work_binding.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/g1_create_work_page.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_page.dart';

import 'package:template/view/screen/v4-employee/work_progress/work_progress_binding.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_progress_page.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_binding.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_page.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_binding.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_page.dart';

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
    GetPage(
      name: AppRoutes.V1_TAX,
      page: () => V1TaxPage(),
    ),
    GetPage(
      name: AppRoutes.V1_JOB_MANAGEMENT,
      page: () => V1JobManagementPage(),
    ),
    GetPage(
      name: AppRoutes.V1_HELP,
      page: () => V1HelpPage(),
    ),
    GetPage(
      name: AppRoutes.V1_CONTRACT,
      page: () => V1ContractPage(),
    ),
    GetPage(
      name: AppRoutes.V1_POINT_BASED,
      page: () => V1PointBasedPage(),
    ),
    GetPage(
      name: AppRoutes.V1_WALLET,
      page: () => V1WalletPage(),
    ),
    GetPage(
      name: AppRoutes.V1_INTRODUCE,
      page: () => V1IntroducePage(),
    ),
    GetPage(
      name: AppRoutes.V1_SHIPPING_METHOD,
      page: () => V1ShippingMethodPage(),
    ),
    GetPage(
      name: AppRoutes.V1_SHIPPING_ADDRESS,
      page: () => V1ShippingAddressPage(),
    ),
    GetPage(
      name: AppRoutes.V1_PAYMENT_ACCOUNT,
      page: () => V1PaymentAccountPage(),
    ),
    GetPage(
      name: AppRoutes.V1_RECHARGE,
      page: () => V1RechargePage(),
    ),
    GetPage(
      name: AppRoutes.V1_PAYMENT_SUCCESS,
      page: () => V1PaymentSuccessPage(),
    ),
    GetPage(
      name: AppRoutes.V1_ACCIDENT_INSURANCE,
      page: () => V1AccidentInsurancePage(),
    ),
    GetPage(
      name: AppRoutes.V1_OTHER_INSURANCE,
      page: () => V1OtherInsurancePage(),
    ),
    GetPage(
      name: AppRoutes.V1_INURANCE_REGISTER,
      page: () => V1InsuranceRegisterPage(),
    ),
    GetPage(
      name: AppRoutes.V1_YOUR_INSURANCE,
      page: () => V1YourInsurancePage(),
    ),
    GetPage(
      name: AppRoutes.V1_INSURANCE_DETAIL,
      page: () => V1InsuranceDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V1_RULES,
      page: () => V1RulesPage(),
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
      page: () => OrderInformationPage(),
      binding: OrderInformationBinding(),
    ),

    ///
    ///Tạo đơn công việc 1- 6
    ///
    GetPage(
      name: AppRoutes.V1_CREATEWORK,
      page: () => CreateWorkPage(),
    ),
    // Nhóm 1
    GetPage(
        name: AppRoutes.V1_G1CREATEWORK,
        page: () => V1G1CreateWorkPage(),
        binding: V1G1CreateWorkBinding()),

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
    //v4 - work progress
    GetPage(
      name: AppRoutes.V4_WORKPROGRESS,
      page: () => V4WorkProgressPage(),
      binding: V4WorkProgressBinding(),
    ),

    GetPage(
      name: AppRoutes.V4_TIMEKEEPING,
      page: () => V4TimekeepingPage(),
      binding: V4TimekeepingBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_REPORT_TIMEKEEPING,
      page: () => V4ReportTimekeepingPage(),
      binding: V4ReportTimekeepingBinding(),
    )
    // GetPage(
    //   name: AppRoutes.INTRO,
    //   page: () => IntroductionPage(),
    // ),
  ];
}
