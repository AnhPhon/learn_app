import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
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
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/v3-agent/dashboard/dashboard_controller.dart';

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

  int soThongBao = 0;

  int number = 0;

  // khai báo is loading
  bool isLoading = true;

  //Id loại tài khoảng
  String idLoaiTaiKhoanThoThau = "6168fb3062f385255f293b0b";
  String idLoaiTaiKhachHang = "6168fb1e62f385255f293afb";
  String idLoaiTaiKhoanNhanVien = "616e71de3535150e7a4d4755";
  String idLoaiTaiKhoanDaiLy = "6168fb1362f385255f293af2";

  //Khai báo đối tượng để lấy thông báo
  String type = "1";

  @override
  void onInit() {
    super.onInit();

    // init refreshController
    refreshController ??= RefreshController();

    // init run
    initProgramRun();
  }

  ///
  /// initProgramRun
  ///
  void initProgramRun() {
    number = 0;
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      print("Kiểm tra id đại lý $id");
      // tìm kiếm tài khoản theo id user được login
      taiKhoanProvider.find(
        id: id!,
        onSuccess: (taiKhoanResponse) {
          // set lại full name theo tài khoản
          fullname = taiKhoanResponse.hoTen!;

          // read tin tuc
          _readTinTuc();

          // read Kho san Pham
          readKhosanPham(id);

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
          readThongBao(
              taiKhoanResponse.id!,
              (taiKhoanResponse.idLoaiTaiKhoan! as LoaiTaiKhoanResponse)
                  .tieuDe!
                  .toLowerCase());
        },
        onError: (error) {
          print("V3HomeController getTermsAndPolicy onError $error");
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
        print("V3HomeController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// read kho san pham
  ///
  void readKhosanPham(String userId) {
    sanPhamProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (sanPhamModels) {
        // get san pham list
        sanPhamList = sanPhamModels;

        // set is loading
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3HomeController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load thông báo
  ///
  void readThongBao(String id, String idLoaiTaiKhoan) {
    soThongBao = 0;

    //Set theo id Loại tài khoản
    soThongBao = 0;

    if (idLoaiTaiKhoan == idLoaiTaiKhoanThoThau) {
      type = "1";
    }

    if (idLoaiTaiKhoan == idLoaiTaiKhoanDaiLy) {
      type = "2";
    }

    if (idLoaiTaiKhoan == idLoaiTaiKhoanNhanVien) {
      type = "3";
    }

    if (idLoaiTaiKhoan == idLoaiTaiKhachHang) {
      type = "4";
    }

    thongBaoProvider.count(
      doiTuong: type,
      idTaiKhoan: id,
      onSuccess: (data) {
        if (data != null && (data as List<dynamic>).isNotEmpty) {
          soThongBao = data[0]['count'] as int;
          update();
        }
      },
      onError: (error) {
        print("V3HomeController getTermsAndPolicy onError $error");
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
      limit: 5,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // chi đăng ký thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '1') {
              number += 1;
              update();
            }

            // cả đăng ký và cam kết thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '2') {
              number += 1;
              update();
            }
          }
        }
      },
      onError: (error) {
        print("V3HomeController dangKyThue onError $error");
      },
    );
  }

  ///
  /// đăng ký fss
  ///
  void dangKyFSS(String id) {
    dangKyHopDongSBSProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models.first.trangThai == '1') {
            number += 1;
            update();
          }
        }
      },
      onError: (error) {
        print("V3HomeController dangKyFSS onError $error");
      },
    );
  }

  ///
  /// đăng ký bảo hiểm tai nạn
  ///
  void dangKyBaoHiemTaiNan(String id) {
    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models.first.trangThai == '1') {
            number += 1;
            update();
          }
        }
      },
      onError: (error) {
        print("V3HomeController dangKyBaoHiemTaiNan onError $error");
      },
    );
  }

  ///
  /// chúng nhận sức khỏe
  ///
  void chungNhanSucKhoe(String id) {
    giayChungNhanSucKhoeProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          if (models[0].trangThai == '1') {
            number += 1;
            update();
          }
        }
      },
      onError: (error) {
        print("V3HomeController chungNhanSucKhoe onError $error");
      },
    );
  }

  ///
  /// on Click News
  ///
  void onClickNews() {
    Get.toNamed(AppRoutes.V1_NEWS);
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
  void onClickHotNews(V3DashboardController v3DashboardController) {
    v3DashboardController.changeTabIndex(3);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNewsDetail(String id) {
    sl.get<SharedPreferenceHelper>().saveTinTuc(id: id);
    tinTucProvider.find(
      id: id,
      onSuccess: (data) {
        Get.toNamed(AppRoutes.V1_NEWS_DETAIL, arguments: data);
      },
      onError: (error) {
        print("V3HomeController goToNewsPageClick $error");
      },
    );
  }

  ///
  /// Nhấn nút sản phẩm
  ///
  void onClickHotProductDetail(String id) {
    sl.get<SharedPreferenceHelper>().saveSanPham(id: id);
    sanPhamProvider.find(
      id: id,
      onSuccess: (data) {
        Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: data);
      },
      onError: (error) {
        print("V3HomeController goToNewsPageClick $error");
      },
    );
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
    sl
        .get<SharedPreferenceHelper>()
        .saveTinTuc(id: tinTucList[index].id.toString());
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL);
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
