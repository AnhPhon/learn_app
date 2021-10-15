import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2WorkflowManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  //set model để thiết kế UI Quản lý công việc
  List<Map<String, dynamic>>? uiWorkflowManagement;

  // cong viec dang lam
  List<CongViecNhanVienResponse> dangLam = [];

  // cong viec hoan thanh
  List<CongViecNhanVienResponse> hoanThanh = [];

  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isRecruiting
  bool isRecruiting = true;

  @override
  void onInit() {
    super.onInit();

    // read cong viec nhan vien
    _readCongViecNhanVien();

    // init work flow
    _initWorkflow();
  }

  ///
  /// get cong viec
  ///
  void _readCongViecNhanVien() {
    congViecNhanVienProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&sortBy=created_at:desc",
      onSuccess: (values) {
        for (final value in values) {
          if (value.trangThai!.toLowerCase() == 'dang lam') {
            dangLam.add(value);
          } else {
            hoanThanh.add(value);
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// init work flow
  ///
  void _initWorkflow() {
    // List model thiết kế UI
    uiWorkflowManagement = [
      {
        "job": "Thợ ốp lát",
        "title": "Công trình khách hàng 4 sao tại Đà Nẵng",
        "city": "Đà Nẵng",
        "address": "Ngũ Hành Sơn",
        "status": "35 ngày",
        "isStatus": false,
        "result": "Chưa nghiệm thu",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ xây tường",
        "title": "Công trình khách hàng 5 sao tại Đà Nẵng",
        "city": "Đà Nẵng",
        "address": "Ngũ Hành Sơn",
        "status": "Đang tuyển",
        "isStatus": true,
        "result": "Đã nghiệm thu",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ lót nền",
        "title": "Công trình khách hàng 4 sao tại Hồ Chí Minh",
        "city": "Hồ Chí Minh",
        "address": "Ngũ Hành Sơn",
        "status": "20 ngày",
        "isStatus": false,
        "result": "Đã quyết toán",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
      {
        "job": "Thợ xây tường",
        "title": "Công trình khách hàng 3 sao tại Hồ Chí Minh",
        "city": "Hồ Chí Minh",
        "address": "Ngũ Hành Sơn",
        "status": "Đang tuyển",
        "isStatus": true,
        "result": "20/08/2021",
        "rate":
            "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.",
      },
    ];
  }

  ///
  ///Click to Work done page
  ///
  void onClickToWorkDonePage() {
    Get.toNamed(AppRoutes.V2_WORK_DONE);
  }

  ///
  ///Click to Work in progress
  ///
  void onClickToWorkInProgressPage() {
    Get.toNamed(AppRoutes.V2_WORK_IN_PROGRESS);
  }
}
