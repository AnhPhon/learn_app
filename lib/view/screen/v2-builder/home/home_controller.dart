import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/giay_chung_nhan_suc_khoe_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2HomeController extends GetxController {
  // provider
  final SanPhamProvider _sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  final TinTucProvider _tinTucProvider = GetIt.I.get<TinTucProvider>();
  final DonDichVuProvider _donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final TaiKhoanProvider _taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  DangKyBaoHiemProvider dangKyBaoHiemProvider =
      GetIt.I.get<DangKyBaoHiemProvider>();
  DangKyHopDongSBSProvider dangKyHopDongSBSProvider =
      GetIt.I.get<DangKyHopDongSBSProvider>();
  GiayChungNhanSucKhoeProvider giayChungNhanSucKhoeProvider =
      GetIt.I.get<GiayChungNhanSucKhoeProvider>();

  // refresh controller
  RefreshController? refreshController;

  // list
  List<String>? idCongViecDangCanNguoiList = ["1", "2", "5", "6"];
  List<Map<String, dynamic>>? contentGrid;
  List<DonDichVuResponse> donDichVuList = [];
  List<SanPhamResponse> sanPhamList = [];
  List<TinTucResponse> tinTucList = [];

  // bool
  bool thueValid = false;
  bool camKetValid = false;
  bool hopDongValid = false;
  bool baoHiemValid = false;
  bool chungNhanValid = false;
  bool maSoThueValid = false;

  int number = 3 + 2;

  String fullname = "Nguyễn Văn A";

  bool isLoading = true;
  bool canNguoiLoading = true;

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
    number = 5 + 2;

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

          // dang ky thue
          dangKyThue(id);

          // dang ky fss
          dangKyFSS(id);

          // dang ky bao hiem tai nan
          dangKyBaoHiemTaiNan(id);

          // chứng nhận sức khỏe
          chungNhanSucKhoe(id);

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
    donDichVuList = [];
    _donDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$idNguoiDung",
      onSuccess: (values) {
        for (final value in values) {
          final int index = idCongViecDangCanNguoiList!
              .indexOf(value.idNhomDichVu!.nhomDichVu!);
          bool isLoadValid = true;

          // check trang thai don hang
          if (value.idTrangThaiDonDichVu == null) {
            isLoadValid = false;
          }

          // check trang thai don hang
          if (value.id == null) {
            isLoadValid = false;
          }

          // check trang thai don hang
          if (value.tieuDe == null) {
            isLoadValid = false;
          }

          // check hình ảnh
          if (value.hinhAnhChiTiet == null) {
            isLoadValid = false;
          }

          if (isLoadValid == true && index != -1) {
            donDichVuList.add(value);
          }
        }
        canNguoiLoading = false;
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
  /// đăng ký thuế
  ///
  void dangKyThue(String id) {
    dangKyThueProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1' && models[0].loai == '1') {
            thueValid = true;
            update();
          }

          if (models[0].trangThai == '1' && models[0].loai == '2') {
            thueValid = true;
            maSoThueValid = true;
            camKetValid = true;
            number -= 2;
            update();
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// đăng ký fss
  ///
  void dangKyFSS(String id) {
    dangKyHopDongSBSProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            hopDongValid = true;
            number -= 1;
            update();
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// đăng ký bảo hiểm tai nạn
  ///
  void dangKyBaoHiemTaiNan(String id) {
    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            baoHiemValid = true;
            number -= 1;
            update();
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// chúng nhận sức khỏe
  ///
  void chungNhanSucKhoe(String id) {
    giayChungNhanSucKhoeProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idTaiKhoan=$id",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            chungNhanValid = true;
            number -= 1;
            update();
          }
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// init three features
  ///
  void _initThreeFeatures() {
    // private
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

  // private
}
