import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:tiengviet/tiengviet.dart';

class V3WarehouseController extends GetxController {
  //NhapKhoHangDaiLy
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider =
      GetIt.I.get<NhapKhoHangDaiLyProvider>();
  List<NhapKhoHangDaiLyResponse> nhapKhoHangDaiLyList = [];

  //KhoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider =
      GetIt.I.get<KhoHangDaiLyProvider>();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;

  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //TextEditingController
  final searchController = TextEditingController();

  //title appbar
  String title = "Kho sản phẩm";

  //user id
  String userId = "";

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //onchange icon (search or close)
  bool isSearched = false;

  //page for for load more refresh
  int pageSearchMax = 1;
  int limiSearchtMax = 8;

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingProduct = true;
  bool isLoadingSearch = false;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getKhoHang();
  }

  @override
  void onClose() {
    refreshController.dispose();
    searchController.dispose();
    super.onClose();
  }

  ///
  ///get khoHang
  ///
  Future<void> getKhoHang() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          khoHangDaiLyList = value;
          khoHangDaiLyResponse = value.first;

          //get product
          getProductByIdKhoHang(isRefresh: true);
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3WarehouseController khoHangDaiLyPaginate onError $error");
      },
    );
  }

  ///
  ///get product
  ///
  void getProductByIdKhoHang({required bool isRefresh}) {
    // //isRefresh
    if (isRefresh) {
      pageMax = 1;
      nhapKhoHangDaiLyList.clear();
    } else {
      //is load more
      pageMax++;
    }
    //get product by idTaiKhoan
    nhapKhoHangDaiLyProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idKhoHangDaiLy=${khoHangDaiLyResponse!.id}&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is empty
        if (value.isEmpty) {
          if (isRefresh) {
            refreshController.refreshCompleted();
          } else {
            refreshController.loadNoData();
          }
        } else {
          //isRefresh
          if (isRefresh) {
            nhapKhoHangDaiLyList = value;
            refreshController.refreshCompleted();
          } else {
            //is load more
            nhapKhoHangDaiLyList = nhapKhoHangDaiLyList.toList() + value;
            refreshController.loadComplete();
          }
        }
        isLoadingSearch = false;
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("V3WarehouseController getProduct onError $error");
      },
    );
  }

  ///
  ///search product
  ///
  void searchProduct(
    BuildContext context, {
    required bool isRefresh,
  }) {
    //isRefresh
    if (isRefresh) {
      pageSearchMax = 1;
      nhapKhoHangDaiLyList.clear();
    } else {
      pageSearchMax++;
    }

    //get data search
    if (searchController.text.isNotEmpty) {
      nhapKhoHangDaiLyProvider.paginate(
        page: pageSearchMax,
        limit: limiSearchtMax,
        filter:
            "&idKhoHangDaiLy=${khoHangDaiLyResponse!.id}&tenSearch=${TiengViet.parse(searchController.text)}&sortBy=created_at:desc",
        onSuccess: (data) {
          //check is empty
          if (data.isEmpty) {
            if (isRefresh) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadNoData();
            }
          } else {
            //isRefresh
            if (isRefresh) {
              nhapKhoHangDaiLyList = data;
              refreshController.refreshCompleted();
            } else {
              //is load more
              nhapKhoHangDaiLyList = nhapKhoHangDaiLyList.toList() + data;
              refreshController.loadComplete();
            }
          }

          FocusScope.of(context).requestFocus(FocusNode());
          isSearched = true;
          isLoadingSearch = false;
          update();
        },
        onError: (error) {
          print("V1ProductController searchProduct onError $error");
        },
      );
    }
  }

  ///
  ///btn search
  ///
  void btnSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      isLoadingSearch = true;
      update();
      searchProduct(context, isRefresh: true);
    }
  }

  ///
  ///clear search
  ///
  void clearSearch(BuildContext context) {
    isLoadingSearch = true;
    //clear text
    searchController.clear();
    isSearched = false;

    //reset noData
    refreshController.resetNoData();

    //reload
    getProductByIdKhoHang(isRefresh: true);
    FocusScope.of(context).requestFocus(FocusNode());
    update();
  }

  ///
  ///onChanged khoHang
  ///
  void onChangedKhoHang(KhoHangDaiLyResponse value) {
    isLoadingProduct = true;
    //resetNoData
    refreshController.resetNoData();
    khoHangDaiLyResponse = value;
    getProductByIdKhoHang(isRefresh: true);
    update();
  }

  ///
  ///onRefresh
  ///
  Future<void> onRefresh(BuildContext context) async {
    //resetNoData
    refreshController.resetNoData();

    if (isSearched) {
      searchProduct(context, isRefresh: true);
    } else {
      //reload page
      getProductByIdKhoHang(isRefresh: true);
    }
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading(BuildContext context) async {
    if (isSearched) {
      searchProduct(context, isRefresh: true);
    } else {
      //get product more
      getProductByIdKhoHang(isRefresh: false);
    }
  }

  ///
  ///go to to receive page
  ///
  void onToReceiveClick() {
    Get.toNamed(AppRoutes.V3_TO_RECEIVE)!.then((value) {
      if (value == true) {
        isLoadingProduct = true;
        refreshController.resetNoData();
        update();
        getProductByIdKhoHang(isRefresh: true);
      }
    });
  }
}
