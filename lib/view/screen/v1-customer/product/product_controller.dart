import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1ProductController extends GetxController {
  // provider
  SanPhamProvider sanPhamProvider = SanPhamProvider();

  // list
  List<SanPhamResponse> sanPhamList = [];

  final searchController = TextEditingController();
  String title = "Sản phẩm";

  @override
  void onInit() {
    super.onInit();

    // load san pham theo muc san pham
    sl
        .get<SharedPreferenceHelper>()
        .productCategoryId
        .then((productCategoryId) {
      // load sản phẩm theo id người dùng
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
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
        print("LENGTH: ${sanPhamList.length}");
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///go to product detail
  ///
  void onProductDetailClick() {
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL);
  }
}
