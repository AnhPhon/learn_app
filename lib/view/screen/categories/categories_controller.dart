import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';

class CategoriesController extends GetxController
    with SingleGetTickerProviderMixin {
  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  bool isLoading = true;

  TabController? tabController;
  int isSelectedTabCateg = 0;

  List<CategoryModel> categoriesList = [];
  List<ProductModel> productWithIdCategList = [];
  ProductModel? productWithId;

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

      // set tab active
      tabController!.index = int.parse(Get.parameters['indexTab'].toString());

      // getProductWithIdCateg(id: Get.parameters['idCategory'].toString());
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
      isSelectedTabCateg = tabController!.index;

      // load data product with id categories
      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
    });
  }

  ///
  ///lấy sản phẩm theo danh mục
  ///
  void getProductWithIdCateg({required String id}) {
    isLoading = true;
    productWithIdCategList.clear();
    update();

    // get data product filter by id category
    productProvider.paginate(
        page: 1,
        limit: 5,
        filter: "idCategory=$id",
        onSuccess: (value) {
          productWithIdCategList = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  ///xem sản phẩm
  ///
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
