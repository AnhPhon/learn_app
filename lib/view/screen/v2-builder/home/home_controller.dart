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
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_controller.dart';

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
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  // refresh controller
  RefreshController? refreshController;

  // list
  List<String>? idCongViecDangCanNguoiList = ["1", "2", "5", "6"];
  List<Map<String, dynamic>>? contentGrid;
  List<DonDichVuResponse> donDichVuList = [];
  List<SanPhamResponse> sanPhamList = [];
  List<TinTucResponse> tinTucList = [];

  List<String> congViecDangCanNguoiCheckList = [
    DA_DUYET,
    DA_PHAN_HOI,
    CHOT_GIA,
  ];

  int number = 0;
  int soThongBao = 0;

  String fullname = "Nguyễn Văn A";

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

    // init features
    _initFeatures();
  }

  ///
  /// init feature
  ///
  void _initFeatures() {
    number = 0;

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

          // thong bao
          readThongBao(id, value.idLoaiTaiKhoan!.id!.toString());

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
        update();
      },
      onError: (error) {
        print("V3HomeController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load công việc đang cần người
  ///
  void _loadCongViecDangCanNguoi(String idNguoiDung) {
    _donDichVuProvider.paginate(
      page: 1,
      limit: 2,
      filter:
          "&idTrangThaiDonDichVu=$DA_DUYET&idNhomDichVuExclude=$NHOM_DICH_VU_7,$NHOM_DICH_VU_8&sortBy=created_at:desc",
      onSuccess: (values) {
        donDichVuList = values;
        isLoading = false;
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
      limit: 5,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // chi đăng ký thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '1') {
              number += 1;
            }

            // cả đăng ký và cam kết thuế hợp lệ
            if (model.trangThai == '1' && model.loai == '2') {
              number += 1;
            }
          }
          update();
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
      limit: 10,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // đăng ký hợp đồng SBS
            if (model.trangThai == '1') {
              number += 1;
              update();
              break;
            }
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
      limit: 10,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // đăng ký bảo hiểm
            if (model.idBaoHiem != null) {
              if (model.idBaoHiem!.loai.toString() == '1') {
                number += 1;
                update();
                break;
              }
            }
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
      limit: 10,
      filter: "&idTaiKhoan=$id&sortBy=created_at:desc",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          for (final model in models) {
            // giấy chừng nhận sức khỏe
            if (model.trangThai == '1') {
              number += 1;
              update();
              break;
            }
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
    Get.toNamed(AppRoutes.V2_SHORTHANDED)!.then((value) {
      onRefresh();
    });
  }

  ///
  ///go to shorthanded page item
  ///
  void onShortHandedPageClickItem(DonDichVuResponse donDichVuResponse) {
    if (donDichVuResponse.idNhomDichVu == null) return;
    if (donDichVuResponse.idNhomDichVu!.id.toString() == NHOM_DICH_VU_1) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP1, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    } else if (donDichVuResponse.idNhomDichVu!.id.toString() ==
        NHOM_DICH_VU_2) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP2, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    } else if (donDichVuResponse.idNhomDichVu!.id.toString() ==
        NHOM_DICH_VU_3) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP3, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    } else if (donDichVuResponse.idNhomDichVu!.id.toString() ==
        NHOM_DICH_VU_4) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP4, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    } else if (donDichVuResponse.idNhomDichVu!.id.toString() ==
        NHOM_DICH_VU_5) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP5, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    } else if (donDichVuResponse.idNhomDichVu!.id.toString() ==
        NHOM_DICH_VU_6) {
      Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP6, arguments: {
        'id': donDichVuResponse.id,
        'title': 'Công việc đang cần người'
      });
    }
  }

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.PRODUCT)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// xem chi tiết 1 sản phẩm
  ///
  void onClickProductDetail(SanPhamResponse sanPham) {
    sl.get<SharedPreferenceHelper>().saveSanPham(id: sanPham.id!);
    Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: sanPham)!.then((value) {
      _loadSanPham();
    });
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews(V2DashboardController controller) {
    controller.changeTabIndex(3);
  }

  ///
  /// vào tin tức chi tiết
  ///
  void onClickHotNewsDetail(TinTucResponse idNews) {
    sl.get<SharedPreferenceHelper>().saveTinTuc(id: idNews.id!);
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL, arguments: idNews)!.then((value) {
      _loadTinTuc();
    });
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickJobManagement() {
    Get.toNamed(AppRoutes.V2_WORKFLOW_MANAGEMENT)!.then((value) {
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
        // load cong viec đang cần người
        _loadCongViecDangCanNguoi(userId!);
      });
    });
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickRecruitment() {
    Get.toNamed(AppRoutes.V2_CANDIDATE_RECRUITMENT)!.then((value) {
      onRefresh();
    });
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    sl
        .get<SharedPreferenceHelper>()
        .saveTinTuc(id: tinTucList[index].id.toString());
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL)!.then((value) {
      // load tin tuc
      _loadTinTuc();
    });
  }

  ///
  /// on Need Update Click
  ///
  void onNeedUpdateClick() {
    number = 0;
    Get.toNamed(AppRoutes.V2_FINISH_UPDATE, arguments: THO_THAU)!.then((value) {
      sl.get<SharedPreferenceHelper>().userId.then((id) {
        id = id.toString();
        // dang ky thue
        dangKyThue(id);

        // dang ky fss
        dangKyFSS(id);

        // dang ky bao hiem tai nan
        dangKyBaoHiemTaiNan(id);

        // chứng nhận sức khỏe
        chungNhanSucKhoe(id);
      });
    });
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    _initFeatures();
    refreshController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    refreshController!.loadComplete();
  }
}
