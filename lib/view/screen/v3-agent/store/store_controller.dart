import 'package:get/get.dart';
import 'package:template/data/model/response/category_store_model.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';

class V3StoreController extends GetxController {
  //title
  String title = "DL,Danahome";

  //categoriesStore list
  List<V3CategoriesStore> categoriesStore = [
    V3CategoriesStore(
      title: "Quản lý sản phẩm",
      urlImg: Images.product_management,
      routes: AppRoutes.V3_PRODUCT_MANAGEMENT,
    ),
    V3CategoriesStore(
      title: "Quản lý đơn hàng",
      urlImg: Images.bill_management,
      routes: AppRoutes.V3_ORDER_MANAGEMENT,
    ),
    V3CategoriesStore(
      title: "Kho sản phẩm",
      urlImg: Images.warehouse_store,
      routes: AppRoutes.V3_WAREHOUSE,
    ),
    V3CategoriesStore(
      title: "Doanh thu",
      urlImg: Images.sale_performance,
      routes: AppRoutes.V3_REVENUE,
    ),
    V3CategoriesStore(
      title: "Thông tin cửa hàng",
      urlImg: Images.infomation_store,
      routes: AppRoutes.V3_STORE_INFOMATION,
    ),
    V3CategoriesStore(
      title: "Thêm sản phẩm",
      urlImg: Images.product_store,
      routes: AppRoutes.V3_PRODUCT_ADD,
    ),
  ];

  ///
  ///on btn click
  ///
  void onBtnClick(int index) {
    Get.toNamed(categoriesStore[index].routes);
  }
}
