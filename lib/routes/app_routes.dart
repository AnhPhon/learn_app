class AppRoutes {
  static const String SPLASH = '/';
  static const String AUTH = '/auth';
  static const String DASHBOARD = '/dashboard';
  static const String HOME = "/home";
  static const String V1_ABOUT = "/v1_about";
  static const String V1_OBLIGATIONS = "/v1_obligations";
  static const String V1_TERM_AND_POLICY = "/v1_term_and_policy";
  static const String V1_USAGE_PROCEDURE = "/v1_usage_procedure";
  static const String V1_BENEFITS = "/v1_benefits";
  static const String V1_NOTIFICATION = "/v1_notification";
  // Phản hồi dịch vụ thường xuyên click từ thông báo
  static const String V1_ORDER_FEEDBACK_CONTRACTORS =
      "/v1orderfeedbackcontractors";
  // Phản hồi đơn hàng nhóm 5
  static const String V1_GROUP_ORDER_FEEDBACK5 = "/v1_grouporderfeedback5";
  // Phản hồi đơn hàng nhóm 6
  static const String V1_GROUP_ORDER_FEEDBACK6 = "/v1_grouporderfeedback6";
  // Thông tin đơn hàng
  static const String V1_ORDER_INFORAMTION = "/v1_orderinfo";
  // Tạo đơn công việc (Chung)
  static const String V1_CREATE_WORK = "/v1_create_work";
  // Tạo đơn công việc nhóm 1
  static const String V1_G1_CREATE_WORK = "/v1_g1_create_work";
  // Tạo đơn công việc nhóm 2
  static const String V1_G2_CREATE_WORK = "/v1_g2_create_work";
  // Tạo đơn dịch vụ nhóm 3
  static const String V1_G3_CREATE_SERVICE = "/v1_g3_create_service";
  static const String V1_G3_ORDER_QUOTE = "/v1_g3_order_quote";
  static const String V1_G3_ORDER_DETAIL = "/v1_g3_order_detail";
  // Tạo đơn dịch vụ nhóm 4
  static const String V1_G4_CREATE_SERVICE = "/v1_g4_create_service";
  static const String V1_G4_ORDER_QUOTE = "/v1_g4_order_quote";
  static const String V1_G4_ORDER_DETAIL = "/v1_g4_order_detail";
  // Tạo đơn dịch vụ và công việc nhóm 5
  static const String V1_G5_CREATE_SERVICE = "/v1_g5_create_service";
  // Tạo đơn dịch vụ và công việc nhóm 6
  static const String V1_G6_CREATE_SERVICE = "/v1_g6_create_service";
  // Tạo tin tuyển dụng
  static const String V1_G7_RECRUITMENT = '/v1_g7_reccuitment';
  static const String V1_G7_REVIEW = '/v1_g7_review';
  // Trang chính của tuyển dụng ứng viên
  static const String V1_CANDICATE = '/v1_candicate';
  // Xem thông tin hồ sơ
  static const String V1_CANDICATE_PROFILE = '/v1_candicate_profile';
  // Xem lại đơn công viêc
  static const String V1_G1_REVIEW = "/v1_g1_review";
  // Bảng giá đăng tin
  static const String V1_G7_PRICE_LIST = "/v1_g7_price_list";
  // Thành công
  static const String V1_SUCCESSFULLY = "/v1_successfully";
  // Hình thức thanh toán
  static const String V1_FORMAL_PAYMENT = "/v1_formal_payment";

  //static const String V1ORDERFEEDBACKCONTRACTORS = "/v1orderfeedbackcontractors";

  static const String ACCOUNT = '/account';
  static const String LOGIN = '/login';
  static const String INFORMATION_USER = '/information_user';
  static const String ORDER_CONDITION = '/order_condition';
  static const String PAYMENT = '/payment';
  static const String POST = '/post';
  static const String CATEGORIES = '/categories';
  static const String KHOHANGDIEUKIEN = '/khohangdieukien';
  static const String KHOHANGTROGIA = '/khohangtrogia';
  static const String PRODUCT_DETAIL = '/product_detail';
  static const String ORDER = '/order';
  static const String ORDER_DETAIL = '/order_detail';
  static const String HISTORY = '/history';
  static const String RULES = '/rules';
  static const String CHARTS = '/charts';
  static const String INTRO = '/intro';
  static const String NEWS_DETAIL = '/news_detail';
  static const String CARTS = '/carts';
  static const String GROUP = '/group';
  static const String CHECKOUT = '/checkout';
  static const String ADDRESS = '/address';

  static const String PASSWORD_CHANGE = '/password_change';
  static const String EDIT_INFO = '/edit_info';

  //customer
  static const String V1_HOME = '/v1_home';
  static const String V1_PRODUCT = '/v1_product';
  static const String V1_NEWS = '/v1_news';
  static const String V1_PROFILE = '/v1_profile';
  static const String V1_FORM_MANAGEMENT = '/v1_form_management';
  static const String V1_PRODUCT_RESPONSE = '/v1_product_response';
  static const String V1_BILL_DETAIL = '/v1_bill_detail';
  static const String V1_PAYMENT_METHOD = '/v1_payment_method';
  static const String V1_JOB_DETAIL = '/v1_job_detail';
  static const String V1_FORM_LIST = '/v1_form_list';
  static const String V1_PRODUCT_DETAIL = '/v1_product_detail';
  static const String V1_CART = '/v1_cart';
  static const String V1_PERSONAL_INFORMATION = '/v1_personal_information';
  static const String V1_POINT_BASED = '/v1_point_based';
  static const String V1_WALLET = '/v1_wallet';
  static const String V1_RULES = '/v1_rules';
  static const String V1_REVIEW = '/v1_review';
  static const String V1_HISTORY = '/v1_history';
  static const String V1_HELP = '/v1_help';
  static const String V1_JOB_MANAGEMENT = '/v1_job_management';
  static const String V1_INTRODUCE = '/v1_introduce';
  static const String V1_MAIL = '/v1_mail';
  static const String V1_IMAGE_UPDATE = '/v1_image_update';
  static const String V1_CONTRACT = '/v1_contract';
  static const String V1_ACCIDENT_INSURANCE = '/v1_accident_insurance';
  static const String V1_OTHER_INSURANCE = '/v1_other_insurance';
  static const String V1_TAX = '/v1_tax';
  static const String V1_SHIPPING_METHOD = '/v1_shipping_method';
  static const String V1_SHIPPING_ADDRESS = '/v1_shipping_address';
  static const String V1_PAYMENT_ACCOUNT = '/v1_payment_account';
  static const String V1_RECHARGE = '/v1_recharge';
  static const String V1_PAYMENT_SUCCESS = '/v1_payment_success';
  static const String V1_INURANCE_REGISTER = '/v1_insurance_register';
  static const String V1_YOUR_INSURANCE = '/v1_your_insurance';
  static const String V1_INSURANCE_DETAIL = '/v1_insurance_detail';

  static const String V1_NEWS_DETAIL = '/v1_news_detail';

  // dashboard
  static const String V1_DASHBOARD = '/v1_dashboard';
  static const String V2_DASHBOARD = '/v2_dashboard';
  static const String V3_DASHBOARD = '/v3_dashboard';
  static const String V4_DASHBOARD = '/v4_dashboard';

  //employeee
  static const String V4_WORKPROGRESS = '/v4_workprogress';

  static const String V4_TIMEKEEPING = '/v4_timekeeping';
  static const String V4_REPORT_TIMEKEEPING = '/v4_report_timekeeping';
  static const String V4_EXPORT_IMPROT = '/v4_export_import';
  static const String V4_REVENUE_EXPENDITURE = '/v4_revenue_expenditure';

  // Builder
  static const String V2_CANDIDATE_RECRUITMENT = '/v2_candidate_recruitment';
  // Xem tin tuyển dụng
  static const String V2_VIEW_RECRUITMENT_NEWS = '/v2_view_recruitment_news';
  //Xem lịch sử tin đã ứng tuyển và đã lưu
  static const String V2_HISTORY_RECRUITMENT_NEWS = '/v2_history_recruitment_news';
  // Hình thức ứng tuyển
  static const String V2_FORM_OF_SUBMITSSION = '/v2_form_of_submitssion';
  // Đánh văn bản
  static const String V2_TEXT_TYING = '/v2_text_tying';
  // Nộp cv
  static const String V2_CV = '/v2_cv';
  // Xem trước hồ sơ nộp bằng CV
  static const String V2_PREVIEW = '/v2_preview';
  // Xem trước hồ sơ đánh bằng văn bản
  static const String V2_PREVIEW_PROFILE = '/v2_preview_profile';

  static const String V4_ADD_DAILY_REPORT = '/v4_add_daily_report';
  static const String V4_ADD_REPORT_ON_REQUEST = '/v4_add_report_on_request';
}
