import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3WarehouseController extends GetxController {
  //NhapKhoHangDaiLy
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider =
      GetIt.I.get<NhapKhoHangDaiLyProvider>();
  List<NhapKhoHangDaiLyResponse> nhapKhoHangDaiLyResponse = [];

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
  int limitMax = 7;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getProduct(isRefresh: true);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    searchController.dispose();
  }

  ///
  ///get product in warehouse by idUser
  ///
  Future<void> getProduct({required bool isRefresh}) async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      nhapKhoHangDaiLyResponse.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get product by idTaiKhoan
    nhapKhoHangDaiLyProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        //check is empty
        if (value.isEmpty) {
          refreshController.loadNoData();
        } else {
          //show loops
          for (final item in value) {
            //get index where
            final index = nhapKhoHangDaiLyResponse.indexWhere(
                (element) => element.idSanPham!.id == item.idSanPham!.id);

            //if not yet
            if (index == -1) {
              nhapKhoHangDaiLyResponse.add(item);
            } else {
              //already exits
              nhapKhoHangDaiLyResponse[index].soLuong = (int.parse(
                          nhapKhoHangDaiLyResponse[index].soLuong.toString()) +
                      int.parse(item.soLuong.toString()))
                  .toString();
            }
          }

          //isRefresh
          if (isRefresh) {
            refreshController.refreshCompleted();
          } else {
            //is load more
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3WarehouseController getProduct onError $error");
      },
    );
  }

  ///
  ///onRefresh
  ///
  Future<void> onRefresh() async {
    //resetNoData
    refreshController.resetNoData();

    //reload page
    getProduct(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading() async {
    //get product more
    getProduct(isRefresh: false);
  }
}
