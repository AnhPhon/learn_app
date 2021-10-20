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

  List<RefreshController>? refreshControllerList;

  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamResponse = [];

  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamResponse = [];

  int pageMax = 1;
  int limitMax = 5;

  bool isLoading = true;
  bool isLoadingProduct = true;

  String title = "Quản lý sản phẩm";

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
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

        //binding refresh controller
        refreshControllerList = List.generate(
            danhMucSanPhamResponse.length, (_) => RefreshController());

        //get product
        getProductByIdCategory(isRefresh: true);

        //listener tabController
        listenerTabController();

        //stop loading
        isLoading = false;
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
    //listen Tab
    tabController!.addListener(() {
      //check call fisrt times
      if (tabController!.indexIsChanging) {
        sanPhamResponse.clear();
        isLoadingProduct = true;
        update();

        //get product by idCategory
        getProductByIdCategory(isRefresh: true);
      }
    });
  }

  ///
  ///get product by idCategory
  ///
  void getProductByIdCategory({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      sanPhamResponse.clear();
    } else {
      pageMax++;
    }
    //paginate by idCategory
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idDanhMucSanPham=${danhMucSanPhamResponse[tabController!.index].id}&sortBy=created_at:desc",
      onSuccess: (value) {
        if (isRefresh) {
          sanPhamResponse = value;
          refreshControllerList![tabController!.index].refreshCompleted();
          update();
        } else {
          sanPhamResponse = sanPhamResponse.toList() + value;
          refreshControllerList![tabController!.index].loadComplete();
          update();
        }

        if (value.isEmpty) {
          refreshControllerList![tabController!.index].loadNoData();
          update();
        }

        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  Future onRefresh() async {
    refreshControllerList![tabController!.index].resetNoData();
    getProductByIdCategory(isRefresh: true);
  }

  Future onLoading() async {
    getProductByIdCategory(isRefresh: false);
  }
}
