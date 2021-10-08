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
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_binding.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_page.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candidate_profile/candidate_profile_binding.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candidate_profile/candidate_profile_page.dart';
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
import 'package:template/view/screen/v1-customer/news/new_detail/news_detail_page.dart';
import 'package:template/view/screen/v1-customer/news/news_page.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin/order_information_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/bulletin/order_information_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/building_materials/order_feedback_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/building_materials/order_feedback_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g5_car_rent/v1_group_order_feedback5_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g5_car_rent/v1_group_order_feedback5_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g6-excavation/v1_group_order_feedback6_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g6-excavation/v1_group_order_feedback6_page.dart';
import 'package:template/view/screen/v1-customer/payment%20account/payment_account_page.dart';
import 'package:template/view/screen/v1-customer/payment_success/payment_success_page.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_page.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_page.dart';
import 'package:template/view/screen/v1-customer/product/product_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_address/shipping_address_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_method/shipping_method_page.dart';
import 'package:template/view/screen/v1-customer/project/project_detail/project_detail_page.dart';
import 'package:template/view/screen/v1-customer/quote/check/check_page.dart';
import 'package:template/view/screen/v1-customer/quote/done/done_page.dart';
import 'package:template/view/screen/v1-customer/quote/request1/request_page.dart';
import 'package:template/view/screen/v1-customer/quote/request2/request_page.dart';
import 'package:template/view/screen/v1-customer/quote/response/response_page.dart';
import 'package:template/view/screen/v1-customer/recharge/recharge_page.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/create/g4_create_service_binding.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/create/g4_create_service_page.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_detail/g4_order_detail_binding.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_detail/g4_order_detail_page.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_binding.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_page.dart';
import 'package:template/view/screen/v1-customer/services/create_work_page.dart';
import 'package:template/view/screen/v1-customer/services/formal_payment/formal_payment__page.dart';
import 'package:template/view/screen/v1-customer/services/formal_payment/formal_payment_binding.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/create/g1_create_work_binding.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/create/g1_create_work_page.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/reviews/g1_review_binding.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/reviews/g1_review_page.dart';
import 'package:template/view/screen/v1-customer/services/g2-regular_service/create/g2_create_work_binding.dart';
import 'package:template/view/screen/v1-customer/services/g2-regular_service/create/g2_create_work_page.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/create/g3_create_service_binding.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/create/g3_create_service_page.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_detail/g3_order_detail_binding.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_detail/g3_order_detail_page.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_quote/g3_order_quote_binding.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_quote/g3_order_quote_page.dart';
import 'package:template/view/screen/v1-customer/services/g5-car_rental/g5_create_service_binding.dart';
import 'package:template/view/screen/v1-customer/services/g5-car_rental/g5_create_service_page.dart';
import 'package:template/view/screen/v1-customer/services/g6-excavation/g6_create_service_binding.dart';
import 'package:template/view/screen/v1-customer/services/g6-excavation/g6_create_service_page.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_binding.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_page.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_list_binding.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_list_page.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/reviews/g7_review_binding.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/reviews/g7_review_page.dart';
import 'package:template/view/screen/v1-customer/services/successfully_page.dart';
import 'package:template/view/screen/v2-builder/bill_detail_is_buy/bill_detail_is_buy_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/preview/candidate_profile_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/preview/candidate_profile_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/history_recruitment_news_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_page.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v2-builder/payment%20account/payment_account_page.dart';
import 'package:template/view/screen/v2-builder/payment_method/payment_method_page.dart';
import 'package:template/view/screen/v2-builder/payment_success/payment_success_page.dart';
import 'package:template/view/screen/v2-builder/product/cart/cart_page.dart';
import 'package:template/view/screen/v2-builder/product/product_detail/product_detail_page.dart';
import 'package:template/view/screen/v2-builder/product/product_page.dart';
import 'package:template/view/screen/v2-builder/product/shipping_address/shipping_address_page.dart';
import 'package:template/view/screen/v2-builder/product/shipping_method/shipping_method_page.dart';
import 'package:template/view/screen/v2-builder/recharge/recharge_page.dart';
import 'package:template/view/screen/v2-builder/payment%20order/payment_order_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded/shorthanded_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group1/quotation_g1/quotation_g1_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group1/shorthanded_group1_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/after_quotation_g2/after_quotation_g2_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/quotation_g2/quotation_g2_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/shorthanded_group2_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group3/shorthanded_group3_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group4/shorthanded_group4_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group5/quotation_g56/quotation_g56_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group5/shorthanded_group5_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group5/winning_bid/winning_bid_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group6/shorthanded_group6_page.dart';
import 'package:template/view/screen/v3-agent/account/account_page.dart';
import 'package:template/view/screen/v3-agent/account/help/help_page.dart';
import 'package:template/view/screen/v3-agent/account/introduce/introduce_page.dart';
import 'package:template/view/screen/v3-agent/account/point_based/point_based_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/contract/contract_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/insurance_detail/insurance_detail_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/insurance_register/insurance_register_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/other_insurance/other_insurance_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/profile_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/register_and_commit/register_and_commit_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/tax/tax_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/your_insurance/your_insurance_page.dart';
import 'package:template/view/screen/v3-agent/account/rules/rules_page.dart';
import 'package:template/view/screen/v3-agent/account/wallet/wallet_page.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v3-agent/payment_success/payment_success_page.dart';
import 'package:template/view/screen/v3-agent/quote/check/quote_check_page.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_page.dart';
import 'package:template/view/screen/v3-agent/quote/request/quote_request_page.dart';
import 'package:template/view/screen/v3-agent/quote/response/quote_response_page.dart';
import 'package:template/view/screen/v3-agent/order_management/order_management_page.dart';
import 'package:template/view/screen/v3-agent/product_add/product_add_page.dart';
import 'package:template/view/screen/v3-agent/product_management/product_management_page.dart';
import 'package:template/view/screen/v3-agent/revenue/revenue_page.dart';
import 'package:template/view/screen/v3-agent/store/store_page.dart';
import 'package:template/view/screen/v3-agent/store_infomation/store_infomation_page.dart';
import 'package:template/view/screen/v3-agent/warehouse/warehouse_page.dart';
import 'package:template/view/screen/v4-employee/account/info/info_binding.dart';
import 'package:template/view/screen/v4-employee/account/info/info_page.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_binding.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_page.dart';
import 'package:template/view/screen/v4-employee/account/salary/salary_binding.dart';
import 'package:template/view/screen/v4-employee/account/salary/salary_page.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_binding.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_page.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_binding.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_page.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_binding.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_page.dart';
import 'package:template/view/screen/v4-employee/export_import/export_import_binding.dart';
import 'package:template/view/screen/v4-employee/export_import/export_import_page.dart';
// import 'package:template/view/screen/auth/auth_page.dart';
// import 'package:template/view/screen/introduction/introduction_page.dart';
// import 'package:template/view/screen/splash/splash_page.dart';
import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_binding.dart';
import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_page.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_binding.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_page.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_progress_binding.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_progress_page.dart';

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
      name: AppRoutes.V1_ABOUT,
      page: () => const AboutPage(),
    ),
    GetPage(
      name: AppRoutes.V1_BENEFITS,
      page: () => const Benefits(),
    ),
    GetPage(
      name: AppRoutes.V1_TERM_AND_POLICY,
      page: () => const TermsAndPolicy(),
    ),
    GetPage(
      name: AppRoutes.V1_USAGE_PROCEDURE,
      page: () => const UsageProcedure(),
    ),
    GetPage(
      name: AppRoutes.V1_OBLIGATIONS,
      page: () => const RightsAndObligations(),
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
    GetPage(
      name: AppRoutes.V1_NEWS_DETAIL,
      page: () => V1NewsDetailPage(),
    ),

    GetPage(
      name: AppRoutes.V1_PROJECT_DETAIL,
      page: () => V1ProjectDetailPage(),
    ),
    //builder
    GetPage(
      name: AppRoutes.V2_PRODUCT_DETAIL,
      page: () => V2ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V2_CART,
      page: () => V2CartPage(),
    ),
    GetPage(
      name: AppRoutes.V2_SHIPPING_METHOD,
      page: () => V2ShippingMethodPage(),
    ),
    GetPage(
      name: AppRoutes.V2_SHIPPING_ADDRESS,
      page: () => V2ShippingAddressPage(),
    ),
    GetPage(
      name: AppRoutes.V2_PAYMENT_ACCOUNT,
      page: () => V2PaymentAccountPage(),
    ),
    GetPage(
      name: AppRoutes.V2_PRODUCT,
      page: () => V2ProductPage(),
    ),
    GetPage(
      name: AppRoutes.V2_PAYMENT_SUCCESS,
      page: () => V2PaymentSuccessPage(),
    ),
    GetPage(
      name: AppRoutes.V2_RECHARGE,
      page: () => V2RechargePage(),
    ),
    GetPage(
      name: AppRoutes.V2_PAYMENT_METHOD,
      page: () => V2PaymentMethodPage(),
    ),
    GetPage(
      name: AppRoutes.V2_BILL_DETAIL_IS_BUY,
      page: () => V2BillDetailIsBuyPage(),
    ),

    ///
    /// v1 customer quote
    ///
    GetPage(
      name: AppRoutes.V1_QUOTE_REQUEST_1,
      page: () => V1Request1Page(),
    ),
    GetPage(
      name: AppRoutes.V1_QUOTE_REQUEST_2,
      page: () => V1Request2Page(),
    ),
    GetPage(
      name: AppRoutes.V1_QUOTE_CHECK,
      page: () => V1CheckPage(),
    ),
    GetPage(
      name: AppRoutes.V1_QUOTE_DONE,
      page: () => V1DonePage(),
    ),
    GetPage(
      name: AppRoutes.V1_QUOTE_RESPONSE,
      page: () => V1ResponsePage(),
    ),

    ///
    /// Thông báo
    ///
    GetPage(
      name: AppRoutes.V1_NOTIFICATION,
      page: () => V1NotificationPage(),
      binding: V1NotificationBinding(),
    ),

    ///
    /// Phản hồi dịch vụ thường xuyên click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS,
      page: () => V1OrderFeedBackPage(),
      binding: V1OrderFeedBackBinding(),
    ),

    ///
    /// Phản hồi đơn hàng nhóm 5 click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1_GROUP_ORDER_FEEDBACK5,
      page: () => const V1GroupOrderFeedBack5Page(),
      binding: V1OrderFeedBackGroup5Binding(),
    ),

    ///
    /// Phản hồi đơn hàng nhóm 6 click từ thông báo
    ///
    GetPage(
      name: AppRoutes.V1_GROUP_ORDER_FEEDBACK6,
      page: () => const V1GroupOrderFeedBack6Page(),
      binding: V1OrderFeedBackGroup6Binding(),
    ),

    ///
    /// Thông tin đơn hàng
    ///
    GetPage(
      name: AppRoutes.V1_ORDER_INFORAMTION,
      page: () => OrderInformationPage(),
      binding: OrderInformationBinding(),
    ),

    ///
    ///Tạo đơn công việc 1- 6 (Trang chung)
    ///
    GetPage(
      name: AppRoutes.V1_CREATE_WORK,
      page: () => CreateWorkPage(),
    ),
    //tạo đơn công việc Nhóm 1 - tạo đơn
    GetPage(
        name: AppRoutes.V1_G1_CREATE_WORK,
        page: () => V1G1CreateWorkPage(),
        binding: V1G1CreateWorkBinding()),
    // Tạo đơn công việc nhóm 1 - xem đơn (KH)
    GetPage(
        name: AppRoutes.V1_G1_REVIEW,
        page: () => V1G1ReviewPage(),
        binding: V1G1ReviewBinding()),
    // Tạo đơn công việc Nhóm 2 (KH)
    GetPage(
        name: AppRoutes.V1_G2_CREATE_WORK,
        page: () => V1G2CreateWorkPage(),
        binding: V1G2CreateWorkBinding()),
    // Tạo đơn dịch vụ Nhóm 3 (KH)
    GetPage(
        name: AppRoutes.V1_G3_CREATE_SERVICE,
        page: () => V1G3CreateServicePage(),
        binding: V1G3CreateServiceBinding()),
    // Báo giá đơn hàng nhóm 3
    GetPage(
        name: AppRoutes.V1_G3_ORDER_QUOTE,
        page: () => V1G3OrderQuotePage(),
        binding: V1G3OrderQuoteBinding()),
    // Chi tiêt đơn hàng nhóm 3
    GetPage(
        name: AppRoutes.V1_G3_ORDER_DETAIL,
        page: () => V1G3OrderDetailPage(),
        binding: V1G3OrderDetailBinding()),

    // Tạo đơn dich vụ nhóm 4
    GetPage(
        name: AppRoutes.V1_G4_CREATE_SERVICE,
        page: () => V1G4CreateServicePage(),
        binding: V1G4CreateServiceBinding()),
    // Báo giá đơn hàng nhóm 4
    GetPage(
        name: AppRoutes.V1_G4_ORDER_QUOTE,
        page: () => V1G4OrderQuotePage(),
        binding: V1G4OrderQuoteBinding()),
    // Chi tiêt đơn hàng nhóm 4
    GetPage(
        name: AppRoutes.V1_G4_ORDER_DETAIL,
        page: () => V1G4OrderDetailPage(),
        binding: V1G4OrderDetailBinding()),

    // Tạo đơn dich vụ và công việc nhóm 5
    GetPage(
        name: AppRoutes.V1_G5_CREATE_SERVICE,
        page: () => V1G5CreateServicePage(),
        binding: V1G5CreateServiceBinding()),

    // Tạo đơn dich vụ và công việc nhóm 6
    GetPage(
        name: AppRoutes.V1_G6_CREATE_SERVICE,
        page: () => V1G6CreateServicePage(),
        binding: V1G6CreateServiceBinding()),

    // Tạo tin tuyển dụng
    GetPage(
        name: AppRoutes.V1_G7_RECRUITMENT,
        page: () => V1G7RecruitmentPage(),
        binding: V1G7RecruitmentBinding()),

    // Xem lại tin tuyển dụng
    GetPage(
        name: AppRoutes.V1_G7_REVIEW,
        page: () => V1G7ReviewPage(),
        binding: V1G7ReviewBinding()),
    // Bảng giá đăng tin
    GetPage(
        name: AppRoutes.V1_G7_PRICE_LIST,
        page: () => V1G7PriceListPage(),
        binding: V1G7PriceListBinding()),
    GetPage(
        name: AppRoutes.V1_G7_PRICE_LIST,
        page: () => V1G7PriceListPage(),
        binding: V1G7PriceListBinding()),
    // Trang chính tuyển dung ứng viên
    GetPage(
        name: AppRoutes.V1_CANDICATE,
        page: () => V1CandidatePage(),
        binding: V1CandidateBinding()),
    // Xem thông tin của hồ sơ
    // Trang chính tuyển dung ứng viên
    GetPage(
        name: AppRoutes.V1_CANDICATE_PROFILE,
        page: () => V1CandidateProfilePage(),
        binding: V1CandidateProfileBinding()),

    // Hình thức thanh toán
    GetPage(
        name: AppRoutes.V1_FORMAL_PAYMENT,
        page: () => V1FormalPaymentPage(),
        binding: V1FormalPaymentBinding()),

    // Tạo thành công
    GetPage(
      name: AppRoutes.V1_SUCCESSFULLY,
      page: () => const SuccessfullyPage(),
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
    GetPage(
      name: AppRoutes.V2_SHORTHANDED,
      page: () => V2ShorthandedPage(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP1,
      page: () => V2ShorthandedGroup1Page(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP2,
      page: () => V2ShorthandedGroup2Page(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP3,
      page: () => V2ShorthandedGroup3Page(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP4,
      page: () => V2ShorthandedGroup4Page(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP5,
      page: () => V2ShorthandedGroup5Page(),
    ),
    GetPage(
      name: AppRoutes.V2_SHORTHANDED_GROUP6,
      page: () => V2ShorthandedGroup6Page(),
    ),
    GetPage(
      name: AppRoutes.V2_QUOTATION_GROUP1,
      page: () => V2QuotationG1Page(),
    ),
    GetPage(
      name: AppRoutes.V2_QUOTATION_GROUP2,
      page: () => V2QuotationG2Page(),
    ),
    GetPage(
      name: AppRoutes.V2_AFTER_QUOTATION_GROUP2,
      page: () => V2AfterQuotationG2Page(),
    ),
    GetPage(
      name: AppRoutes.V2_QUOTATION_GROUP56,
      page: () => V2QuotationG56Page(),
    ),
    GetPage(
      name: AppRoutes.V2_WINNING_BID,
      page: () => V2WinningBidPage(),
    ),
    GetPage(
      name: AppRoutes.V2_PAYMENT_ORDER,
      page: () => V2PaymentOrderPage(),
    ),

    // Quản lý tuyển dụng ứng viên
    GetPage(
      name: AppRoutes.V2_CANDIDATE_RECRUITMENT,
      page: () => V2RecruitmentPage(),
      binding: V2RecruitmentBinding(),
    ),



    // agent
    GetPage(
      name: AppRoutes.V3_DASHBOARD,
      page: () => V3DashboardPage(),
      binding: V3DashboardBinding(),
    ),
    // v3 - quote list
    GetPage(
      name: AppRoutes.V3_QUOTE_LIST,
      page: () => V3QuoteListPage(),
    ),
    // v3 - quote check
    // Xem lichj tin tuyển dụng ứng viên đã lưu và đã ứng tuyển
    GetPage(
      name: AppRoutes.V2_HISTORY_RECRUITMENT_NEWS,
      page: () => V2HistoryRectuitmentNewsPage(),
    ),

    // Chọn hình thức ứng tuyển
    GetPage(
      name: AppRoutes.V3_QUOTE_CHECK,
      page: () => V3QuoteCheckPage(),
    ),
    // v3 - quote request
    GetPage(
      name: AppRoutes.V3_QUOTE_REQUEST,
      page: () => V3QuoteRequestPage(),
    ),
    // v3 - quote response
    GetPage(
      name: AppRoutes.V3_QUOTE_RESPONSE,
      page: () => V3QuoteResponsePage(),
    ),
    GetPage(
      name: AppRoutes.V3_STORE,
      page: () => V3StorePage(),
    ),
    GetPage(
      name: AppRoutes.V3_PRODUCT_MANAGEMENT,
      page: () => V3ProductManagementPage(),
    ),
    GetPage(
      name: AppRoutes.V3_ORDER_MANAGEMENT,
      page: () => V3OrderManagementPage(),
    ),
    GetPage(
      name: AppRoutes.V3_WAREHOUSE,
      page: () => V3WarehousePage(),
    ),
    GetPage(
      name: AppRoutes.V3_REVENUE,
      page: () => V3RevenuePage(),
    ),
    GetPage(
      name: AppRoutes.V3_STORE_INFOMATION,
      page: () => V3StoreInfomationPage(),
    ),
    GetPage(
      name: AppRoutes.V3_PRODUCT_ADD,
      page: () => V3ProductAddPage(),
    ),
    // Xem trươc đánh văn bản
    GetPage(
      name: AppRoutes.V2_PREVIEW_PROFILE,
      page: () => V2PreviewProfilePage(),
      binding: V2PreviewProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.V3_CONTRACT,
      page: () => V3ContractPage(),
    ),
    GetPage(
      name: AppRoutes.V3_ACCIDENT_INSURANCE,
      page: () => V3AccountPage(),
    ),
    GetPage(
      name: AppRoutes.V3_OTHER_INSURANCE,
      page: () => V3OtherInsurancePage(),
    ),
    GetPage(
      name: AppRoutes.V3_TAX,
      page: () => V3TaxPage(),
    ),
    GetPage(
      name: AppRoutes.V3_INSURANCE_DETAIL,
      page: () => V3InsuranceDetailPage(),
    ),
    GetPage(
      name: AppRoutes.V3_PAYMENT_ACCOUNT,
      page: () => V3PaymentSuccessPage(),
    ),
    GetPage(
      name: AppRoutes.V3_PROFILE,
      page: () => V3ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.V3_POINT_BASED,
      page: () => V3PointBasedPage(),
    ),
    GetPage(
      name: AppRoutes.V3_WALLET,
      page: () => V3WalletPage(),
    ),
    GetPage(
      name: AppRoutes.V3_RULES,
      page: () => V3RulesPage(),
    ),
    GetPage(
      name: AppRoutes.V3_INTRODUCE,
      page: () => V3IntroducePage(),
    ),
    GetPage(
      name: AppRoutes.V3_HELP,
      page: () => V3HelpPage(),
    ),
    GetPage(
      name: AppRoutes.V3_JOB_MANAGEMENT,
      page: () => V3ProductAddPage(),
    ),
    GetPage(
      name: AppRoutes.V3_INURANCE_REGISTER,
      page: () => V3InsuranceRegisterPage(),
    ),
    GetPage(
      name: AppRoutes.V3_YOUR_INSURANCE,
      page: () => V3YourInsurancePage(),
    ),
    GetPage(
      name: AppRoutes.V3_REGISTER_AND_COMMIT,
      page: () => V3RegisterAndCommitPage(),
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
    ),
    GetPage(
      name: AppRoutes.V4_EXPORT_IMPROT,
      page: () => V4ExportImportPage(),
      binding: V4ExportImportBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_REVENUE_EXPENDITURE,
      page: () => V4RevenueExpenditurePage(),
      binding: V4RevenueExpenditureBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_ADD_DAILY_REPORT,
      page: () => V4AddDailyReportPage(),
      binding: V4AddDailyReportBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_ADD_REPORT_ON_REQUEST,
      page: () => V4AddReportOnRequestPage(),
      binding: V4AddReportOnRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_RULES,
      page: () => V4RulesPage(),
      binding: V4RulesBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_SALARY,
      page: () => V4SalaryPage(),
      binding: V4SalaryBinding(),
    ),
    GetPage(
      name: AppRoutes.V4_INFO,
      page: () => V4InfoPage(),
      binding: V4InfoBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.INTRO,
    //   page: () => IntroductionPage(),
    // ),
  ];
}
