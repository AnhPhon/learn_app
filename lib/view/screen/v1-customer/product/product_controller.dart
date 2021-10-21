import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1ProductController extends GetxController {
  // provider
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();

  // refresh controller
  RefreshController refreshController = RefreshController();
  final searchController = TextEditingController();

  // list
  List<SanPhamResponse> sanPhamList = [];
  List<DanhMucSanPhamResponse> danhMucList = [];

  String title = "Sản phẩm";
  String selectIndex = "";

  // bool
  bool isLoading = true;
  bool isSPLoading = true;

  @override
  void onInit() {
    super.onInit();

    // load init
    loadInit();
  }

  ///
  /// load init
  ///
  void loadInit() {
    // load san pham theo muc san pham
    sl
        .get<SharedPreferenceHelper>()
        .productCategoryId
        .then((productCategoryId) {
      // load sản phẩm theo id người dùng
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
        // load danh mục
        _loadDanhMucSanPham();

        // call product
        readProductByCategoryIdAndUserId(userId!, productCategoryId!);
      });
    });
  }

  ///
  /// get san pham theo danh muc
  ///
  void readProductByCategoryIdAndUserId(String idUser, String idSanPham) {
    sanPhamProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDanhMucSanPham=$idSanPham&idTaiKhoan=$idUser",
      onSuccess: (models) {
        sanPhamList = models;
        isSPLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// load danh muc san pham
  ///
  void _loadDanhMucSanPham() {
    // product list
    danhMucSanPhamProvider.all(
      onSuccess: (values) {
        // assign values to productList
        danhMucList = values;
        if (danhMucList.isNotEmpty) {
          sl
              .get<SharedPreferenceHelper>()
              .productCategoryId
              .then((productCategoryId) {
            selectIndex = productCategoryId ?? danhMucList[0].id!;
          });
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
  ///go to product detail
  ///
  void onProductDetailClick(String id) {
    sl.get<SharedPreferenceHelper>().saveProductId(id);
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL);
  }

  ///
  /// on Category Change
  ///
  void onCategoryChange(String? id) {
    selectIndex = id!;
    isSPLoading = true;
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      // call product
      readProductByCategoryIdAndUserId(userId!, selectIndex);
    });
    update();
  }

  ///
  /// on refresh
  ///
  void onRefresh() async {
    loadInit();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  ///
  /// on loading
  ///
  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }
}
