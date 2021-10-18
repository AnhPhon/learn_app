import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images.dart';

class V1HomeController extends GetxController {
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();

  List<Map<String, dynamic>>? threeFeatures;
  List<Map<String, dynamic>>? contentGrid;
  List<SanPhamResponse> productList = [];
  List<TinTucResponse> tinTucList = [];

  String fullname = "KH, Nguyễn Văn A";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

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
  /// init six feature category
  ///
  void _initSixFeatureCategory() {
    // declare content grid
    contentGrid = [
      {
        "label": "Tạo đơn công việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Báo giá VLXD",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xff97DBAE),
            Color(0xff3FA963),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Dịch vụ thường xuyên",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffF1E1A6),
            Color(0xffCEBB76),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Quản lý đơn tạo",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffDECFE5),
            Color(0xffA27DBF),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
        }
      },
      {
        "label": "Quản lý báo giá",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffC3E5AE),
            Color(0xff73AF4E),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE);
        }
      },
      {
        "label": "Tuyển dụng ứng viên",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
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
        "label": "Ảnh sản\nphẩm mẫu",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": CupertinoIcons.bag_fill,
        "onTap": () {}
      },
      {
        "label": "Quản lý\ncông việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": Icons.image,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
        }
      },
      {
        "label": "Sản phẩm\nmẫu",
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
    ];
  }

  ///
  /// load danh muc san pham
  ///
  void _loadDanhMucSanPham() {
    // product list
    sanPhamProvider.paginate(
      page: 1,
      limit: 9,
      filter: "&sortBy=created_at:desc",
      onSuccess: (values) {
        // assign values to productList
        productList = values;

        // xử lý tạm
        if (productList.length != 9) {
          _fillProductList(productList);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
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
  /// Quản lý công việc
  ///
  void onClickJobManagement() {
    //Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }

  ///
  /// lập đấy sản phẩm cho list - xử lý tạm thời
  ///
  void _fillProductList(List<SanPhamResponse> productList) {
    while (productList.length != 9) {
      productList.add(
        SanPhamResponse(ten: "San pham mau", hinhAnhSanPham: Images.logo),
      );
    }
  }
}
