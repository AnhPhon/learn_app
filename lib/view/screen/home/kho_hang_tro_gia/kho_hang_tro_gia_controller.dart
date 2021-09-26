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

  @override
  void onInit() {
    super.onInit();
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
      tabController = TabController(length: categoriesList.length, vsync: this);
      print("tabController!.index: ${tabController!.index}");
      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
      listenerTabController();
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
    tabController!.addListener(() {
      isSelectedTabCateg = tabController!.index;
      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
      update();
    });
  }

  ///
  ///lấy sản phẩm theo danh mục
  ///
  void getProductWithIdCateg({required String id}) {
    productWithIdCategList.clear();
    update();
    productProvider.paginate(
        page: 1,
        limit: 5,
        filter: "idCategory=$id",
        onSuccess: (value) {
          print("trong005");
          productWithIdCategList = value;
          // isLoading = false;
          print("trong00");
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  //xem sản phẩm
  void onProductClick(int index) {
    print("productId=${productWithIdCategList[index].id!}");
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
