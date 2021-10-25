import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

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

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getKhoHang();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    searchController.dispose();
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
          "&idTaiKhoan=$userId&idKhoHangDaiLy=${khoHangDaiLyResponse!.id}&sortBy=created_at:desc",
      onSuccess: (value) {
        print(value.length);
        //check is empty
        if (value.isEmpty) {
          refreshController.loadNoData();
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

        update();
      },
      onError: (error) {
        print("V3WarehouseController getProduct onError $error");
      },
    );
  }

  ///
  ///onChanged khoHang
  ///
  void onChangedKhoHang(KhoHangDaiLyResponse value) {
    //resetNoData
    refreshController.resetNoData();
    khoHangDaiLyResponse = value;
    getProductByIdKhoHang(isRefresh: true);
    update();
  }

  ///
  ///onRefresh
  ///
  Future<void> onRefresh() async {
    //resetNoData
    refreshController.resetNoData();

    //reload page
    getProductByIdKhoHang(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading() async {
    //get product more
    getProductByIdKhoHang(isRefresh: false);
  }
}
