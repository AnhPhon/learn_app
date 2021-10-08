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
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/group-5/v1_group_order_feedback5_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/group-5/v1_group_order_feedback5_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/group-6/v1_group_order_feedback6_binding.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/group-6/v1_group_order_feedback6_page.dart';
import 'package:template/view/screen/v1-customer/payment%20account/payment_account_page.dart';
import 'package:template/view/screen/v1-customer/payment_success/payment_success_page.dart';
import 'package:template/view/screen/v1-customer/product/cart/cart_page.dart';
import 'package:template/view/screen/v1-customer/product/product_detail/product_detail_page.dart';
import 'package:template/view/screen/v1-customer/product/product_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_address/shipping_address_page.dart';
import 'package:template/view/screen/v1-customer/product/shipping_method/shipping_method_page.dart';
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
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/create/cv_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/create/cv_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/preview/preview_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/preview/preview_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/form_of_submission_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/create/text_typing_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/create/text_typing_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/preview/candidate_profile_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/preview/candidate_profile_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/history_recruitment_news_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_page.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/view_recruitment_news/view_recruitment_news_binding.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/view_recruitment_news/view_recruitment_news_page.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_page.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_binding.dart';
import 'package:template/view/screen/v4-employee/dashboard/dashboard_page.dart';
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

    // Quản lý tuyển dụng ứng viên
    GetPage(
      name: AppRoutes.V2_CANDIDATE_RECRUITMENT,
      page: () => V2RecruitmentPage(),
      binding: V2RecruitmentBinding(),
    ),

    // Xem tin tuyển dụng ứng viên
    GetPage(
      name: AppRoutes.V2_VIEW_RECRUITMENT_NEWS,
      page: () => V2ViewRecruitmentNewsPage(),
      binding: V2ViewRecruitmentNewsBinding(),
    ),
    // Xem lichj tin tuyển dụng ứng viên đã lưu và đã ứng tuyển
    GetPage(
      name: AppRoutes.V2_HISTORY_RECRUITMENT_NEWS,
      page: () => V2HistoryRectuitmentNewsPage(),
    ),

    // Chọn hình thức ứng tuyển
    GetPage(
      name: AppRoutes.V2_FORM_OF_SUBMITSSION,
      page: () => V2FormOfSubmitssionPage(),
    ),
    // Đánh văn bản
    GetPage(
      name: AppRoutes.V2_TEXT_TYING,
      page: () => V2TextTypingPage(),
      binding: V2TextTypingBinding(),
    ),
    // Nộp cv
    GetPage(
      name: AppRoutes.V2_CV,
      page: () => V2CvPage(),
      binding: V2CvBinding(),
    ),
    // Xem trươc nộp cv
    GetPage(
      name: AppRoutes.V2_PREVIEW,
      page: () => V2PreviewPage(),
      binding: V2PreviewBinding(),
    ),
    // Xem trươc đánh văn bản
    GetPage(
      name: AppRoutes.V2_PREVIEW_PROFILE,
      page: () => V2PreviewProfilePage(),
      binding: V2PreviewProfileBinding(),
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

    // GetPage(
    //   name: AppRoutes.INTRO,
    //   page: () => IntroductionPage(),
    // ),
  ];
}
