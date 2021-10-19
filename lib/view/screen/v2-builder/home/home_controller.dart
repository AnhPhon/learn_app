import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2HomeController extends GetxController {
  final SanPhamProvider _sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  final TinTucProvider _tinTucProvider = GetIt.I.get<TinTucProvider>();
  final DonDichVuProvider _donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final TaiKhoanProvider _taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  // refresh controller
  RefreshController? refreshController;

  List<String>? idCongViecDangCanNguoiList = ["1", "2", "5", "6"];
  List<Map<String, dynamic>>? contentGrid;
  List<DonDichVuResponse> donDichVuList = [];
  List<SanPhamResponse> sanPhamList = [];
  List<TinTucResponse> tinTucList = [];

  int number = 0;

  String fullname = "Nguyễn Văn A";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    // init refreshController
    refreshController ??= RefreshController();

    // init features
    _initFeatures();
  }

  ///
  /// init feature
  ///
  void _initFeatures() {
    // get user id
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      _taiKhoanProvider.find(
        id: id!,
        onSuccess: (value) {
          fullname = value.hoTen!;

          // load cong viec đang cần người
          _loadCongViecDangCanNguoi(value.id!);

          // load tin tuc
          _loadTinTuc();

          // load san pham
          _loadSanPham();

          // load tin tuc
          _loadTinTuc();

          // khoi tao three feature
          _initThreeFeatures();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load công việc đang cần người
  ///
  void _loadCongViecDangCanNguoi(String idNguoiDung) {
    _donDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$idNguoiDung",
      onSuccess: (values) {
        for (final value in values) {
          final int index = idCongViecDangCanNguoiList!
              .indexOf(value.idNhomDichVu!.nhomDichVu!);

          bool isLoadValid = true;

          // check tai khoan nhan don
          if (value.taiKhoanNhanDon == null) {
            isLoadValid = false;
          }

          // check trang thai don hang
          if (value.idTrangThaiDonHang == null) {
            isLoadValid = false;
          }

          if (isLoadValid && index != -1) {
            donDichVuList.add(value);
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
  /// load san pham
  ///
  void _loadSanPham() {
    _sanPhamProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=created_at:desc",
      onSuccess: (value) {
        sanPhamList = value;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load tin tuc
  ///
  void _loadTinTuc() {
    _tinTucProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=created_at:desc",
      onSuccess: (value) {
        tinTucList = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  void _initThreeFeatures() {
    // declare content grid
    contentGrid = [
      {
        "label": ["Đăng ký", "việc"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V2_WORK_REGISTER);
        }
      },
      {
        "label": ["Quản lý", "công việc"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xff97DBAE),
            Color(0xff3FA963),
          ],
        ),
        "icon": Icons.checklist_rtl_sharp,
        "onTap": () {
          onClickJobManagement();
        }
      },
      {
        "label": ["Tin tuyển", "dụng"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffF1E1A6),
            Color(0xffCEBB76),
          ],
        ),
        "icon": Icons.pending_actions,
        "onTap": () {
          onClickRecruitment();
        }
      },
    ];
  }

  ///
  ///go to shorthanded page
  ///
  void onShortHandedPageClick() {
    Get.toNamed(AppRoutes.V2_SHORTHANDED);
  }

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.V2_PRODUCT);
  }

  ///
  /// xem chi tiết 1 sản phẩm
  ///
  void onClickProductDetail(String id) {
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews() {
    Get.toNamed(AppRoutes.V2_NEWS);
  }

  ///
  /// vào tin tức chi tiết
  ///
  void onClickHotNewsDetail(String idNews) {
    Get.toNamed(AppRoutes.V2_NEWS_DETAIL);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickJobManagement() {
    Get.toNamed(AppRoutes.V2_WORKFLOW_MANAGEMENT);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickRecruitment() {
    Get.toNamed(AppRoutes.V2_CANDIDATE_RECRUITMENT);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickRegisterJob() {
    // Đăng ký viẹc mới
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucList[index].id}");
  }

  ///
  /// on Need Update Click
  ///
  void onNeedUpdateClick() {
    Get.toNamed(AppRoutes.V2_FINISH_UPDATE);
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    _initFeatures();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.loadComplete();
  }
}
