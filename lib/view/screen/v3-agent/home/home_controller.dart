import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_hop_dong_s_b_s_provider.dart';
import 'package:template/provider/dang_ky_thue_provider.dart';
import 'package:template/provider/giay_chung_nhan_suc_khoe_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3HomeController extends GetxController {
  // provider
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  DangKyThueProvider dangKyThueProvider = GetIt.I.get<DangKyThueProvider>();
  DangKyBaoHiemProvider dangKyBaoHiemProvider =
      GetIt.I.get<DangKyBaoHiemProvider>();
  DangKyHopDongSBSProvider dangKyHopDongSBSProvider =
      GetIt.I.get<DangKyHopDongSBSProvider>();
  GiayChungNhanSucKhoeProvider giayChungNhanSucKhoeProvider =
      GetIt.I.get<GiayChungNhanSucKhoeProvider>();

  // refresh controller
  RefreshController? refreshController;

  String fullname = "Nguyễn Văn A";
  List<Map<String, dynamic>>? threeFeatures;
  List<TinTucResponse> tinTucList = [];
  List<SanPhamResponse> sanPhamList = [];
  List<ThongBaoResponse> thongBaoList = [];

  int number = 0;

  // khai báo is loading
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    number = 5 + 2;

    // init refreshController
    refreshController ??= RefreshController();

    // init run
    initProgramRun();
  }

  ///
  /// initProgramRun
  ///
  void initProgramRun() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      // tìm kiếm tài khoản theo id user được login
      taiKhoanProvider.find(
        id: id!,
        onSuccess: (taiKhoanResponse) {
          // set lại full name theo tài khoản
          fullname = taiKhoanResponse.hoTen!;

          // read tin tuc
          _readTinTuc();

          // read Kho san Pham
          readKhosanPham();

          // binding three feature
          bindingThreeFeature();

          // dang ky thue
          dangKyThue(id);

          // dang ky fss
          dangKyFSS(id);

          // dang ky bao hiem tai nan
          dangKyBaoHiemTaiNan(id);

          // chứng nhận sức khỏe
          chungNhanSucKhoe(id);

          // load notification
          readThongBao(taiKhoanResponse.idLoaiTaiKhoan!.tieuDe!.toLowerCase());
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// read tin tuc
  ///
  void _readTinTuc() {
    tinTucProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=created_at:desc",
      onSuccess: (tinTucResponses) {
        // get tin tuc list
        tinTucList = tinTucResponses;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// read kho san pham
  ///
  void readKhosanPham() {
    sanPhamProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=created_at:desc",
      onSuccess: (sanPhamModels) {
        // get san pham list
        sanPhamList = sanPhamModels;

        // set is loading
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load thông báo
  ///
  void readThongBao(String tieuDe) {
    String type = "1";
    if (tieuDe == 'khách hàng') {
      type = "1";
    }

    if (tieuDe == 'thợ thầu') {
      type = "2";
    }

    if (tieuDe == 'đại lý') {
      type = "3";
    }

    if (tieuDe == 'nhân viên') {
      type = "4";
    }

    thongBaoProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&doiTuong=$type",
      onSuccess: (data) {
        thongBaoList = data;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// binding three feature
  ///
  void bindingThreeFeature() {
    threeFeatures = [
      {
        "icon": Icons.shop,
        "label": ["Cửa hàng", "của bạn"],
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff8CE3E9),
          Color(0xff8CE3E9),
        ]),
        "onTap": () {
          onClickStore();
        }
      },
      {
        "icon": Icons.chat,
        "label": ["Phản hồi", "báo giá"],
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffC1E6EE),
        ]),
        "onTap": () {
          onClickQuoteReponse();
        }
      },
      {
        "icon": Icons.request_page,
        "label": ["Yêu cầu", "báo giá"],
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff79B4B8),
          Color(0xff79B4B8),
        ]),
        "onTap": () {
          onClickQuoteRequest();
        }
      },
    ];
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
          if (models[0].trangThai == '1' && models[0].loai == '2') {
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
  /// on Click News
  ///
  void onClickNews() {
    Get.toNamed(AppRoutes.V3_NEWS);
  }

  ///
  /// Tơi màn hình quản lý sản phẩm
  ///
  void onClickWareHouse() {
    Get.toNamed(AppRoutes.V3_WAREHOUSE);
  }

  ///
  /// yeu cầu báo giá
  ///
  void onClickQuoteRequest() {
    Get.toNamed(AppRoutes.V3_QUOTE_LIST);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews() {
    Get.toNamed(AppRoutes.V2_NEWS);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNewsDetail(String id) {
    // goto detail news
    Get.toNamed("${AppRoutes.V2_NEWS_DETAIL}?id=$id");
  }

  ///
  /// Nhấn nút sản phẩm
  ///
  void onClickHotProductDetail(String id) {
    sl.get<SharedPreferenceHelper>().saveSanPham(id: id);
    // goto detail news
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL);
  }

  ///
  /// Phản hòi báo giá
  ///
  void onClickQuoteReponse() {
    Get.toNamed(AppRoutes.V3_PHAN_HOI_BAO_GIA);
  }

  ///
  /// Cửa hàng
  ///
  void onClickStore() {
    Get.toNamed(AppRoutes.V3_STORE);
  }

  ///
  /// on Need Update Click
  ///
  void onNeedUpdateClick() {
    Get.toNamed(AppRoutes.V2_FINISH_UPDATE);
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucList[index].id}");
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    initProgramRun();
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
