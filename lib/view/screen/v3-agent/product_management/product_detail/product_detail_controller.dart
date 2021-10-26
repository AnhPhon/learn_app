import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/san_pham_provider.dart';

class V3ProductDetailController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  // initialize scroll controller
  ScrollController? scrollController;

  //SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamList = [];
  SanPhamResponse sanPhamResponse = SanPhamResponse();

  //title appbar
  String title = "Chi tiết sản phẩm";

  //loading
  bool isLoading = true;
  bool isLoadingMore = false;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  @override
  void onInit() {
    super.onInit();
    //binding ScrollController
    scrollController = ScrollController()..addListener(() {});

    //get arguments
    sanPhamResponse = Get.arguments as SanPhamResponse;

    //get load data
    getMoreProduct(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController!.dispose();
    refreshController.dispose();
    super.onClose();
  }

  ///
  ///get more product
  ///
  void getMoreProduct({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      sanPhamList.clear();
    } else {
      //is load more
      pageMax++;
    }

    //load sanPhamList
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idDanhMucSanPham=${sanPhamResponse.idDanhMucSanPham!.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        data.removeWhere((element) => element.id == sanPhamResponse.id);
        //check is empty
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          //isRefresh
          if (isRefresh) {
            sanPhamList = data;
            refreshController.refreshCompleted();
          } else {
            //is load more
            sanPhamList = sanPhamList.toList() + data;
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3ProductDetailController getMoreProduct onError $error");
      },
    );
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //isloading
    isLoading = true;

    //reset noData
    refreshController.resetNoData();

    //load sanPham
    getMoreProduct(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //load sanPham
    getMoreProduct(isRefresh: false);
  }

  ///
  /// show more
  ///
  void loadingMore() {
    isLoadingMore = false;
    update();
  }

  ///
  /// show less
  ///
  void loadingLess() {
    isLoadingMore = true;
    update();
  }

  ///
  ///on get Product
  ///
  void onGetProduct({required int index}) {
    //back top
    scrollToTop();

    //reload data
    sanPhamResponse = sanPhamList[index];
    getMoreProduct(isRefresh: true);
  }

  ///
  ///scroll to top when click other product
  ///
  void scrollToTop() {
    scrollController!.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
