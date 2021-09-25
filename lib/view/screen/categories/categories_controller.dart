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

  TabController? tabController;

  List<CategoryModel> categoriesList = [];

  List<ProductModel> productWithIdList = [];

  ProductModel? productWithId;

  int isSelectedTabCateg = 0;

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  //lấy tất cả danh mục
  void getAllCategories() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;
      tabController = TabController(length: categoriesList.length, vsync: this);
      tabController!.addListener(() {
        isSelectedTabCateg = tabController!.index;
        getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
      });
      getProductWithIdCateg(id: categoriesList[isSelectedTabCateg].id!);
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  //lấy sản phẩm theo danh mục
  void getProductWithIdCateg({required String id}) {
    isLoading = true;
    update();
    productProvider
        .paginate(
            page: 1,
            limit: 5,
            filter: "idCategory=$id",
            onSuccess: (value) {
              productWithIdList = value;
              isLoading = false;
            },
            onError: (error) {
              print(error);
            })
        .then((value) => update());
  }

  //xem sản phẩm
  void onProductClick(int index) {
    productProvider
        .find(
            id: productWithIdList[index].id!,
            onSuccess: (value) {
              productWithId = value;
              update();
            },
            onError: (error) {
              print(error);
              update();
            })
        .then((values) => Get.toNamed(AppRoutes.PRODUCT_DETAIL));
  }
}
