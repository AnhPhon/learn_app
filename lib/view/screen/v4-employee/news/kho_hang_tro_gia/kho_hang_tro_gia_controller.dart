import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';

class KhoHangTroGiaController extends GetxController
    with SingleGetTickerProviderMixin {
  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  TabController? tabController;

  List<CategoryModel> categoriesList = [];

  List<ProductModel> productWithIdCategList = [];
  ProductModel? productWithId;

  int isSelectedTabCateg = 0;

  bool isLoading = true;
  bool isLoadingListView = true;

  @override
  void onInit() {
    super.onInit();
    // get all categries
    getAllCategories();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  ///
  ///lấy tất cả danh mục
  ///
  void getAllCategories() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;

      // binding data tab
      tabController = TabController(length: categoriesList.length, vsync: this);

      // listen tab controller
      listenerTabController();

      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///listener tabController
  ///
  void listenerTabController() {
    // listen tab
    tabController!.addListener(() {
      // add loading and clear data
      isLoadingListView = true;
      productWithIdCategList.clear();
      update();

      // load data product with id categories
      isSelectedTabCateg = tabController!.index;
      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
    });
  }

  ///
  ///lấy sản phẩm theo danh mục
  ///
  void getProductWithIdCateg({required String id}) {
    // get data product filter by id category
    productProvider.paginate(
        page: 1,
        limit: 5,
        filter: "idCategory=$id",
        onSuccess: (value) {
          productWithIdCategList = value;
          isLoadingListView = false;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  //xem sản phẩm
  void onProductClick(int index) {
    productProvider
        .find(
            id: productWithIdCategList[index].id!,
            onSuccess: (value) {
              productWithId = value;

              update();
            },
            onError: (error) {
              print(error);
              update();
            })
        .then((values) => Get.toNamed(
            "${AppRoutes.PRODUCT_DETAIL}?productId=${productWithIdCategList[index].id!}&categoryId=${productWithIdCategList[index].idCategory}&price=${productWithIdCategList[index].prices}"));
  }
}
