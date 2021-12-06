import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_controller.dart';

class V1HomeController extends GetxController {
  // declare provider
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();

  // refresh controller
  RefreshController? refreshController;

  // declare list
  List<Map<String, dynamic>>? threeFeatures;
  List<Map<String, dynamic>>? contentGrid;
  List<SanPhamResponse> productList = [];
  List<TinTucResponse> tinTucList = [];
  List<DanhMucSanPhamResponse> danhMucList = [];

  // declare string
  String fullname = "Nguyễn Văn A";

  // declare boolean
  bool isLoading = true;

  int soThongBao = 0;

  //Id loại tài khoảng
  String idLoaiTaiKhoanThoThau = "6168fb3062f385255f293b0b";
  String idLoaiTaiKhachHang = "6168fb1e62f385255f293afb";
  String idLoaiTaiKhoanNhanVien = "616e71de3535150e7a4d4755";
  String idLoaiTaiKhoanDaiLy = "6168fb1362f385255f293af2";

  //Khai báo đối tượng để lấy thông báo
  String type = "1";

  //donHang
  // DonHangProvider donHangProvider = GetIt.I.get();
  // DonHangResponse? donHangResponse;

  //chiTietDonHang
  // ChiTietDonHangProvider chiTietDonHangProvider = GetIt.I.get();
  // List<ChiTietDonHangResponse> chiTietDonHangList = [];

  @override
  void onInit() {
    super.onInit();

    refreshController = RefreshController();

    loadInit();
  }

  ///
  /// init six feature category
  ///
  void _initSixFeatureCategory() {
    // declare content grid
    contentGrid = [
      {
        "label": ["Tạo đơn", "công việc"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK, arguments: SERVICES.WORK)!
              .then((value) {
            onRefresh();
          });
        }
      },
      {
        "label": ["Báo giá", "VLXD"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xff97DBAE),
            Color(0xff3FA963),
          ],
        ),
        "icon": Icons.request_quote_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_BAO_GIA_VAT_LIEU_XAY_DUNG)!.then((value) {
            onRefresh();
          });
        }
      },
      {
        "label": ["Dịch vụ", "thường xuyên"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffF1E1A6),
            Color(0xffCEBB76),
          ],
        ),
        "icon": Icons.room_service_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK, arguments: SERVICES.REGULARLY)!
              .then((value) {
            onRefresh();
          });
        }
      },
      {
        "label": ["Quản lý", "đơn tạo"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffDECFE5),
            Color(0xffA27DBF),
          ],
        ),
        "icon": Icons.widgets_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT)!.then((value) {
            onRefresh();
          });
        }
      },
      {
        "label": ["Quản lý", "báo giá"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffC3E5AE),
            Color(0xff73AF4E),
          ],
        ),
        "icon": Icons.work_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_QUOTE_LIST)!.then((value) {
            onRefresh();
          });
        }
      },
      {
        "label": ["Tuyển dụng", "ứng viên"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.drive_file_rename_outline_outlined,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CANDICATE)!.then((value) {
            onRefresh();
          });
        }
      },
    ];
  }

  ///
  /// init product image category
  ///
  void _initProductImageCategory() {
    // three features
    threeFeatures = [
      // {
      //   "label": ["Ảnh sản", "phẩm mẫu"],
      //   "gradient": const RadialGradient(
      //     radius: 1,
      //     colors: [
      //       Color(0xffB4DDFD),
      //       Color(0xffB4DDFD),
      //     ],
      //   ),
      //   "icon": Icons.image,
      //   "onTap": () {}
      // },
      {
        "label": ["Quản lý", "công việc"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": CupertinoIcons.bag_fill,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT)!.then((value) {
            onRefresh();
          });
        }
      },
    ];
  }

  ///
  /// load danh muc san pham
  ///
  void _loadDanhMucSanPham() {
    // product list
    danhMucSanPhamProvider.paginate(
      page: 1,
      limit: 9,
      filter: "",
      onSuccess: (values) {
        // assign values to productList
        danhMucList = values;

        // xử lý tạm
        if (danhMucList.length != 9) {
          _fillProductList(danhMucList);
        }
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
    tinTucProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=created_at:desc",
      onSuccess: (values) {
        tinTucList = values;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// onClickFormManagementPage
  ///
  void onClickFormManagementPage() {
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Tới trang Tạo đơn công việc
  ///
  void onClickCreateWork() {
    Get.toNamed(AppRoutes.V1_CREATE_WORK)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// go to Product Page
  ///
  void onMoreProductList() {
    Get.toNamed(AppRoutes.PRODUCT)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// xem thêm category sản phẩm
  ///
  void onMoreCategoryProduct({required int index}) {
    Get.toNamed(AppRoutes.PRODUCT, arguments: danhMucList[index])!
        .then((value) {
      onRefresh();
    });
  }

  ///
  /// đến màn hình tuyển dung úng vieen
  ///
  void onClickCandicate() {
    Get.toNamed(AppRoutes.V1_CANDICATE)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews(V1DashboardController v1DashboardController) {
    v1DashboardController.changeTabIndex(3);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void goToNewPageClick(TinTucResponse idNews) {
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL, arguments: idNews)!.then((value) {
      onRefresh();
    });
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void goToSanPhamPageClick(SanPhamResponse idHangMucSanPham) {
    Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: idHangMucSanPham)!
        .then((value) {
      onRefresh();
    });
  }

  ///
  /// Quản lý công việc
  ///
  void onClickJobManagement() {
    //Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }

  ///
  /// load init
  ///
  void loadInit() {
    // load thông tin
    sl.get<SharedPreferenceHelper>().userId.then(
      (id) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: id!,
          onSuccess: (value) {
            // set user
            fullname = value.hoTen!;

            // load san pham
            _loadDanhMucSanPham();

            // load tin tuc
            _loadTinTuc();

            // thong bao
            readThongBao(
              id,
              value.idLoaiTaiKhoan!.tieuDe!.toString().toLowerCase(),
            );

            // init six feature category
            _initSixFeatureCategory();

            // init product image category
            _initProductImageCategory();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
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
  /// on refresh
  ///
  Future<void> onRefresh() async {
    loadInit();
    refreshController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    refreshController!.loadComplete();
  }

  ///
  /// lập đấy sản phẩm cho list - xử lý tạm thời
  ///
  void _fillProductList(List<DanhMucSanPhamResponse> productList) {
    while (productList.length != 9) {
      productList.add(
        DanhMucSanPhamResponse(
          ten: "San pham mau",
        ),
      );
    }
  }
}
