class AppRoutes {
  static const String SPLASH = '/';

  // auth
  static const String AUTH = '/auth';
  static const String FORGOT_PASSWORD = '/forgot_password';
  static const String OTP_VERIFIER = '/otp_verifier';
  static const String UPDATE_PASSWORD = '/update_password';
  static const String REGISTER = '/register';
  static const String LOGIN_EMPLOYEE = '/login_employee';

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

  // Phản hồi đơn hàng nhóm 1
  static const String V1_BUILD_ORDER_FEEDBACK = '/v1_build_order_feedback';

  // Phản hồi đơn hàng nhóm 6
  static const String V1_GROUP_ORDER_FEEDBACK6 = "/v1_grouporderfeedback6";

  // Thông tin đơn hàng
  static const String V1_ORDER_INFORAMTION = "/v1_orderinfo";
  static const String V1_FEEDBACK_ORDER_INFORAMTION = "/v1_feedback_orderinfo";

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
  //

  //
  static const String V1_FORMAL_FEEDBACK_PAYMENT =
      "/v1_formal_feedback_payment";
  static const String V1_DETAIL_NOTIFICATION = "/v1_detail_notification";

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
  static const String V1_INSURANCE_DETAIL = '/v1_insurance_detail';

  static const String V1_NEWS_DETAIL = '/v1_news_detail';
  static const String V1_PROJECT_DETAIL = '/v1_project_detail';

  static const String V1_QUOTE_REQUEST_1 = '/v1_quote_request_1';
  static const String V1_QUOTE_REQUEST_2 = '/v1_quote_request_2';
  static const String V1_QUOTE_CHECK = '/v1_quote_check';
  static const String V1_QUOTE_DONE = '/v1_quote_done';
  static const String V1_QUOTE_RESPONSE = '/v1_quote_response';
  static const String V1_QUOTE_NO_RESPONSE = '/v1_quote_no_response';
  static const String V1_QUOTE_LIST = '/V1_QUOTE_LIST';
  static const String V1_MY_ORDER = '/v1_my_order';
  static const String V1_BEFORE_RECHARGE = '/v1_before_recharge';
  static const String V1_ACCOUNT = '/v1_account_page';
  static const String V1_REFERENCE_PRICE_TABLE = '/v1_reference_price_table';
  static const String V1_ORDER_DETAIL = '/v1_order_detail';
  static const String V1_SERVICE_REVIEW_G1 = '/v1_service_review_g1';
  static const String V1_SERVICE_REVIEW_G2 = '/v1_service_review_g2';
  static const String V1_SERVICE_REVIEW_G3 = '/v1_service_review_g3';
  static const String V1_SERVICE_REVIEW_G4 = '/v1_service_review_g4';
  static const String V1_SERVICE_REVIEW_G5 = '/v1_service_review_g5';
  static const String V1_SERVICE_REVIEW_G6 = '/v1_service_review_g6';

  // dashboard
  static const String V1_DASHBOARD = '/v1_dashboard';
  static const String V2_DASHBOARD = '/v2_dashboard';
  static const String V3_DASHBOARD = '/v3_dashboard';
  static const String V4_DASHBOARD = '/v4_dashboard';

  // builder
  static const String V2_QUOTE_LIST = '/v2_quote_list';
  static const String V2_QUOTE_CHECK = '/v2_quote_check';
  static const String V2_QUOTE_RESPONSE = '/v2_quote_response';
  static const String V2_QUOTE_REQUEST = '/v2_quote_request';
  static const String V2_CONTRACT = '/v2_contract';
  static const String V2_REGISTER_AND_COMMIT = '/v2_register_and_commit';
  static const String V2_ACCIDENT_INSURANCE = '/v2_accident_insurance';
  static const String V2_OTHER_INSURANCE = '/v2_other_insurance';
  static const String V2_TAX = '/v2_tax';
  static const String V2_INSURANCE_DETAIL = '/v2_insurance_detail';
  static const String V2_PAYMENT_ACCOUNT = '/v2_payment_account';
  static const String V2_PROFILE = '/v2_profile';
  static const String V2_POINT_BASED = '/v2_point_based';
  static const String V2_WALLET = '/v2_wallet';
  static const String V2_RULES = '/v2_rules';
  static const String V2_INTRODUCE = '/v2_introduce';
  static const String V2_HELP = '/v2_help';
  static const String V2_JOB_MANAGEMENT = '/v2_job_management';
  static const String V2_INURANCE_REGISTER = '/v2_inurance_register';
  static const String V2_YOUR_INSURANCE = '/v2_your_insurance';
  static const String V2_PAYMENT_SUCCESS = '/v2_payment_success';
  static const String V2_RECHARGE = '/v2_recharge';
  static const String V2_NEWS_DETAIL = '/v2_news_detail';
  static const String V2_PROJECT_DETAIL = '/v2_project_detail';
  static const String V2_PROJECT_DETAIL_TRIEN_KHAI =
      '/v2_project_detail_trien_khai';
  static const String V2_PROJECT_DANG_KY_TRIEN_KHAI =
      '/v2_project_dang_ky_trien_khai';

  //builder
  static const String V2_SHORTHANDED = '/v2_shorthanded';
  static const String V2_SHORTHANDED_GROUP1 = '/v2_shorthanded_group1';
  static const String V2_SHORTHANDED_GROUP2 = '/v2_shorthanded_group2';
  static const String V2_SHORTHANDED_GROUP3 = '/v2_shorthanded_group3';
  static const String V2_SHORTHANDED_GROUP4 = '/v2_shorthanded_group4';
  static const String V2_SHORTHANDED_GROUP5 = '/v2_shorthanded_group5';
  static const String V2_SHORTHANDED_GROUP6 = '/v2_shorthanded_group6';
  static const String V2_QUOTATION_GROUP1 = '/v2_quotation_group1';
  static const String V2_QUOTATION_GROUP2 = '/v2_quotation_group2';
  static const String V2_AFTER_QUOTATION_GROUP2 = '/v2_after_quotation_group2';
  static const String V2_QUOTATION_GROUP56 = '/v2_quotation_group56';
  static const String V2_WINNING_BID = '/v2_winning_bid';
  static const String V2_PAYMENT_ORDER = '/v2_payment_order';
  static const String V2_FINISH_UPDATE = '/v2_finish_update';

  // agent
  static const String V3_QUOTE_LIST = '/v3_quote_list';
  static const String V3_QUOTE_CHECK = '/v3_quote_check';
  static const String V3_QUOTE_RESPONSE = '/v3_quote_response';
  static const String V3_QUOTE_REQUEST = '/v3_quote_request';
  static const String V3_CONTRACT = '/v3_contract';
  static const String V3_REGISTER_AND_COMMIT = '/v3_register_and_commit';
  static const String V3_ACCIDENT_INSURANCE = '/v3_accident_insurance';
  static const String V3_OTHER_INSURANCE = '/v3_other_insurance';
  static const String V3_TAX = '/v3_tax';
  static const String V3_INSURANCE_DETAIL = '/v3_insurance_detail';
  static const String V3_PAYMENT_ACCOUNT = '/v3_payment_account';
  static const String V3_PROFILE = '/v3_profile';
  static const String V3_POINT_BASED = '/v3_point_based';
  static const String V3_WALLET = '/v3_wallet';
  static const String V3_RULES = '/v3_rules';
  static const String V3_INTRODUCE = '/v3_introduce';
  static const String V3_HELP = '/v3_help';
  static const String V3_JOB_MANAGEMENT = '/v3_job_management';
  static const String V3_INURANCE_REGISTER = '/v3_inurance_register';
  static const String V3_YOUR_INSURANCE = '/v3_your_insurance';
  static const String V3_PAYMENT_SUCCESS = '/v3_payment_success';
  static const String V3_RECHARGE = '/v3_recharge';
  static const String V3_NEWS_DETAIL = '/v3_news_detail';
  static const String V3_NEWS = '/v3_news';
  static const String V3_FINISH_UPDATE = '/v3_finish_update';
  static const String V3_PHAN_HOI_BAO_GIA = '/v3_finish_update';
  static const String V3_PROJECT_DETAIL_TRIEN_KHAI =
      '/v3_project_detail_trien_khai';
  static const String V3_PROJECT_DANG_KY_TRIEN_KHAI =
      '/v3_project_dang_ky_trien_khai';
  static const String V3_ORDER_DETAIL = '/v3_order_detail';
  static const String V3_PRODUCT_DETAIL = '/v3_product_detail';

  //employeee
  static const String V4_WORKPROGRESS = '/v4_workprogress';
  static const String V4_DETAIL_WORK = '/v4_detail_work';

  static const String V4_TIMEKEEPING = '/v4_timekeeping';
  static const String V4_REPORT_TIMEKEEPING = '/v4_report_timekeeping';
  static const String V4_EXPORT_IMPROT = '/v4_export_import';
  static const String V4_REVENUE_EXPENDITURE = '/v4_revenue_expenditure';
  static const String V4_NEWS_DETAIL = '/v4_news_detail';
  static const String V4_NEWS = '/v4_news';

  static const String V4_NOTIFICATION = '/v4_notification';
  static const String V4_DETAIL_NOTIFICATION = '/v4_detail_notification';
  static const String V4_DETAIL_REPORT = '/v4_detail_report';

  //builder

  static const String V2_PRODUCT = '/v2_product';
  static const String V2_NEWS = '/v2_news';
  static const String V2_CART = '/v2_cart';
  static const String V2_PRODUCT_DETAIL = '/v2_product_detail';
  static const String V2_SHIPPING_METHOD = '/v2_shipping_method';
  static const String V2_SHIPPING_ADDRESS = '/v2_shipping_address';
  static const String V2_PAYMENT_METHOD = '/v2_payment_method';
  static const String V2_BILL_DETAIL_IS_BUY = '/v2_bill_detail_is_buy';
  static const String V3_STORE = '/v3_store';
  static const String V3_PRODUCT_MANAGEMENT = '/v3_product_management';
  static const String V3_ORDER_MANAGEMENT = '/v3_order_management';
  static const String V3_WAREHOUSE = '/v3_warehouse';
  static const String V3_REVENUE = '/v3_revenue';
  static const String V3_STORE_INFOMATION = '/v3_store_infomaion';
  static const String V3_PRODUCT_ADD = '/v3_product_add';
  static const String V3_TO_RECEIVE = '/v3_to_receive';

  // Builder
  static const String V2_CANDIDATE_RECRUITMENT = '/v2_candidate_recruitment';

  // Xem tin tuyển dụng
  static const String V2_VIEW_RECRUITMENT_NEWS = '/v2_view_recruitment_news';

  //Xem lịch sử tin đã ứng tuyển và đã lưu
  static const String V2_HISTORY_RECRUITMENT_NEWS =
      '/v2_history_recruitment_news';
  //Tìm kiếm tin đã ứng tuyển
  static const String V2_SEARCH_RECRUITMENT_NEWS =
      '/v2_search_recruitment_news';

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

  // đăng ký công việc
  static const String V2_WORK_REGISTER = '/v2_work_register';

  static const String V4_ADD_DAILY_REPORT = '/v4_add_daily_report';
  static const String V4_ADD_REPORT_ON_REQUEST = '/v4_add_report_on_request';
  static const String V4_RULES = '/v4_rules';
  static const String V4_SALARY = '/v4_salary';
  static const String V4_INFO = '/v4_info';

  //builder
  static const String V2_WORKFLOW_MANAGEMENT = '/v2_workflow_management';
  static const String V2_WORK_DONE = '/v2_work_done';
  static const String V2_WORK_IN_PROGRESS = '/v2_work_in_progress';
  static const String V2_DETAIL_WORK_DONE = '/v2_detail_work_done';
  static const String V2_DETAIL_WORK_IN_PROGRESS =
      '/v2_detail_work_in_progress';

  // Builder
  // static const String V2_CANDIDATE_RECRUITMENT = '/v2_candidate_recruitment';

  ///payment
  static const String PAYMENT_ACCOUNT = '/payment_account';
  static const String PAYMENT_SUCCESS = '/payment_success';
  static const String PAYMENT_RECHARGE = '/payment_recharge';
  static const String ORDER_INFORMATION = '/order_infomation';
}
