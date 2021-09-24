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

  List<ProductModel> productWithIdList = [];

  int isSelectedTabCateg = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //lấy tất cả danh mục
  void getAllCategories() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;
      update();
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
    productProvider.paginate(
        page: 1,
        limit: 5,
        filter: "idCategory=$id",
        onSuccess: (value) {
          productWithIdList = value;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void onProductClick() {
    Get.toNamed(AppRoutes.PRODUCT_DETAIL);
  }
}
