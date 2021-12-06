import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3ProductManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  //tabController
  TabController? tabController;

  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  //DanhMucSanPham
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamResponse = [];

  //SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamResponse = [];

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingProduct = true;

  //user id
  String userId = "";

  // title appbar
  String title = "Quản lý sản phẩm";

  @override
  void onInit() {
    super.onInit();
    //get load data
    getUserId().then(
      (value) {
        getAllCategory();
      },
    );
  }

  @override
  void onClose() {
    tabController!.dispose();
    refreshControllerList!.clear();
    super.onClose();
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get all category
  ///
  void getAllCategory() {
    danhMucSanPhamProvider.all(
      onSuccess: (value) {
        danhMucSanPhamResponse = value;
        danhMucSanPhamResponse.insert(0, DanhMucSanPhamResponse(ten: "Tất cả"));
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

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3ProductManagementController getAllCategory onError $error");
      },
    );
  }

  ///
  ///listener tab controller
  ///
  void listenerTabController() {
    //listen Tab
    tabController!.addListener(
      () {
        //check call fisrt times
        if (tabController!.indexIsChanging) {
          isLoadingProduct = true;
          update();

          //get product by idCategory
          getProductByIdCategory(isRefresh: true);
        }
      },
    );
  }

  ///
  ///get product by idCategory
  ///
  void getProductByIdCategory({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      sanPhamResponse.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get product by idDanhMucSanPham
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: (tabController!.index == 0)
          ? "&idTaiKhoan=$userId&sortBy=created_at:desc"
          : "&idTaiKhoan=$userId&idDanhMucSanPham=${danhMucSanPhamResponse[tabController!.index].id}&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is empty
        if (value.isEmpty) {
          if (isRefresh) {
            refreshControllerList![tabController!.index].refreshCompleted();
          } else {
            refreshControllerList![tabController!.index].loadNoData();
          }
        } else {
          //isRefresh
          if (isRefresh) {
            sanPhamResponse = value;
            refreshControllerList![tabController!.index].refreshCompleted();
          } else {
            //is load more
            sanPhamResponse = sanPhamResponse.toList() + value;
            refreshControllerList![tabController!.index].loadComplete();
          }
        }

        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///on refresh
  ///
  Future onRefresh() async {
    refreshControllerList![tabController!.index].resetNoData();
    getProductByIdCategory(isRefresh: true);
  }

  ///
  ///on loading
  ///
  Future onLoading() async {
    getProductByIdCategory(isRefresh: false);
  }

  ///
  ///on product detail click
  ///
  void onProductDetailClick({required int index}) {
    Get.toNamed(AppRoutes.V3_PRODUCT_DETAIL, arguments: sanPhamResponse[index]);
  }
}
