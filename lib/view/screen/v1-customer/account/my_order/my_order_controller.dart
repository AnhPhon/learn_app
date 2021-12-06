import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1MyOrderController extends GetxController
    with SingleGetTickerProviderMixin {
  //tabController
  TabController? tabController;

  //refresh controller for load more refresh
  List<RefreshController> refreshController = [];

  //donHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  List<DonHangResponse> donHangResponse = [];

  //user id
  String userId = "";

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingOrder = true;

  //text color
  Map<String, Color> statusColor = {
    "Mới tạo": const Color(0xff007D3A),
    "Xác nhận": const Color(0xff007D3A),
    "Chuẩn bị hàng": const Color(0xff0D5BB5),
    "Đang giao": const Color(0xffCC8100),
    "Đã giao": const Color(0xff831e8a),
    "Huỷ đơn": const Color(0xffBF1D28),
    "Trả hàng": const Color(0xffA6A6B0),
  };

  //background color
  Map<String, Color> statusBackgroundColor = {
    "Mới tạo": const Color(0x1f007D3A),
    "Xác nhận": const Color(0x1f007D3A),
    "Chuẩn bị hàng": const Color(0x1f0D5BB5),
    "Đang giao": const Color(0x1fCC8100),
    "Đã giao": const Color(0x2f831e8a),
    "Huỷ đơn": const Color(0x1fBF1D28),
    "Trả hàng": const Color(0x3fA6A6B0),
  };

  //title app bar
  String title = "Trạng thái đơn hàng";

  @override
  void onInit() {
    super.onInit();

    //binding tabController
    tabController =
        TabController(length: trangThaiDonHangMap.length, vsync: this);

    //binding refreshController
    refreshController =
        List.generate(trangThaiDonHangMap.length, (_) => RefreshController());

    //get load data
    getOrder(idTrangThaiDonHang: trangThaiDonHangMap.values.toList()[0]);

    //listener TabController
    listenerTabController();
  }

  @override
  void onClose() {
    tabController!.dispose();
    refreshController.clear();
    super.onClose();
  }

  ///
  ///get order by idTaiKhoanMuaHang & idTrangThaiDonHang
  ///
  Future<void> getOrder({required String idTrangThaiDonHang}) async {
    //clear list
    pageMax = 1;
    donHangResponse.clear();

    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get order by idTaiKhoanMuaHang & idTrangThaiDonHang
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=$idTrangThaiDonHang&sortBy=updated_at:desc",
      onSuccess: (value) {
        donHangResponse = value;

        //remove don hang moi tao chua thanh toan
        if (idTrangThaiDonHang == TRANG_THAI_DON_HANG_MOI_TAO) {
          donHangResponse.removeWhere(
              (element) => element.idTrangThaiThanhToan!.id == CHUA_THANH_TOAN);
        }
        
        isLoading = false;
        isLoadingOrder = false;
        update();
      },
      onError: (error) {
        print("V1MyOrderController getOrder onError $error");
      },
    );
  }

  ///
  ///listener tabController
  ///
  void listenerTabController() {
    // listen tab
    tabController!.addListener(() {
      // check call first time
      if (tabController!.indexIsChanging) {
        //start CircularProgressIndicator
        isLoadingOrder = true;

        //resetNoData
        refreshController[tabController!.index].resetNoData();

        //get order
        getOrder(
            idTrangThaiDonHang:
                trangThaiDonHangMap.values.toList()[tabController!.index]);
      }
    });
  }

  ///
  ///loading order by idOrderStatus
  ///
  void pullOrder({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      donHangResponse.clear();
    } else {
      //isLoading
      pageMax++;
    }

    //pull to refresh or load more
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=${trangThaiDonHangMap.values.toList()[tabController!.index]}&sortBy=updated_at:desc",
      onSuccess: (value) {
        //remove don hang moi tao chua thanh toan
        if (tabController!.index == 0) {
          value.removeWhere(
              (element) => element.idTrangThaiThanhToan!.id == CHUA_THANH_TOAN);
        }

        //check data is empty
        if (value.isEmpty) {
          //isRefresh
          if (isRefresh) {
            refreshController[tabController!.index].refreshCompleted();
          } else {
            //is load more
            refreshController[tabController!.index].loadNoData();
          }
        } else {
          //is Refresh
          if (isRefresh) {
            donHangResponse = value;
            refreshController[tabController!.index].refreshCompleted();
          } else {
            //is load more
            donHangResponse = donHangResponse.toList() + value;
            refreshController[tabController!.index].loadComplete();
          }
        }

        isLoadingOrder = false;
        update();
      },
      onError: (error) {
        print("V1MyOrderController pullOrder onError $error");
      },
    );
  }

  //onRefresh
  Future<void> onRefresh() async {
    //resetNoData
    refreshController[tabController!.index].resetNoData();
    //get order isRefresh
    pullOrder(isRefresh: true);
  }

  //onLoading
  Future<void> onLoading() async {
    //get order isLoading
    pullOrder(isRefresh: false);
  }

  ///
  ///go to order detail page
  ///
  void onOrderClick({required int index}) {
    Get.toNamed(AppRoutes.V1_ORDER_DETAIL, arguments: donHangResponse[index]);
  }
}
