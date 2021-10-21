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
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/v1-customer/project/project_controller.dart';

class V1HomeController extends GetxController {
  // declare provider
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
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
          Get.toNamed(AppRoutes.V1_CREATE_WORK, arguments: SERVICES.WORK);
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
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
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
          Get.toNamed(AppRoutes.V1_CREATE_WORK, arguments: SERVICES.REGULARLY);
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
          Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
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
          Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE);
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
          Get.toNamed(AppRoutes.V1_CANDICATE);
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
      {
        "label": ["Ảnh sản", "phẩm mẫu"],
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": Icons.image,
        "onTap": () {}
      },
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
          Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
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
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
  }

  ///
  /// Tới trang Tạo đơn công việc
  ///
  void onClickCreateWork() {
    Get.toNamed(AppRoutes.V1_CREATE_WORK);
  }

  /// go to Form List Page
  ///
  void onClickFormList() {
    Get.toNamed(AppRoutes.V1_FORM_LIST);
  }

  ///
  /// go to Product Page
  ///
  void onMoreProductList() {
    Get.toNamed(AppRoutes.V1_PRODUCT);
  }

  ///
  /// go to Product detail Page
  ///
  void onMoreProductDetail(String s) {
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL);
  }

  ///
  /// xem thêm category sản phẩm
  ///
  void onMoreCategoryProduct(String id) {
    sl.get<SharedPreferenceHelper>().saveProductCategoryId(id);
    Get.toNamed(AppRoutes.V1_PRODUCT);
  }

  ///
  /// đến màn hình tuyển dung úng vieen
  ///
  void onClickCandicate() {
    Get.toNamed(AppRoutes.V1_CANDICATE);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews() {
    Get.toNamed(AppRoutes.V1_NEWS);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void goToNewPageClick(String idNews) {
    sl.get<SharedPreferenceHelper>().saveTinTuc(id: idNews);
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=$idNews");
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void goToSanPhamPageClick(String idHangMucSanPham) {
    sl.get<SharedPreferenceHelper>().saveSanPham(id: idHangMucSanPham);
    onMoreProductList();
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
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            fullname = value.hoTen!;

            // load san pham
            _loadDanhMucSanPham();

            // load tin tuc
            _loadTinTuc();

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
  /// on refresh
  ///
  Future<void> onRefresh() async {
    loadInit();
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
