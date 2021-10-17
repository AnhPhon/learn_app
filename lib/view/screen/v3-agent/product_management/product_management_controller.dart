import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';

class V3ProductManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;
  int indexTab = 0;

  RefreshController refreshController = RefreshController();

  DanhMucSanPhamProvider danhMucSanPhamProvider = GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamResponse = [];

  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamResponse = [];

  int pageMax = 1;
  int limitMax = 5;

  bool isLoading = true;
  bool isLoadingProduct = true;

  List categoriesList = [
    "Tất cả",
    "Vật liệu xây dựng",
    "Nội thất",
    "Thiết bị",
  ];

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String title = "Quản lý sản phẩm";

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  ///
  ///get all category
  ///
  void getAllCategory() {
    danhMucSanPhamProvider.all(
      onSuccess: (value) {
        danhMucSanPhamResponse = value;

        //binding tab controller
        tabController =
            TabController(length: danhMucSanPhamResponse.length, vsync: this);

        //listener tab controller
        listenerTabController();

        //get product
        getProductByIdCategory(index: tabController!.index, isRefresh: true);

        isLoading = false;
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///listener tab controller
  ///
  void listenerTabController() {
    tabController!.addListener(() {
      getProductByIdCategory(index: tabController!.index, isRefresh: true);
    });
  }

  ///
  ///get product by idCategory
  ///
  void getProductByIdCategory({required int index, required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      sanPhamResponse.clear();
    } else {
      pageMax++;
    }
    isLoadingProduct = true;
    update();

    //paginate by idCategory
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idDanhMucSanPham=${danhMucSanPhamResponse[index].id}",
      onSuccess: (value) {
        print(value);
        sanPhamResponse = value;
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
