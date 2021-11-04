import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

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
    "Xác nhận": const Color(0xff007D3A),
    "Chuẩn bị hàng": const Color(0xff0D5BB5),
    "Đang giao": const Color(0xffCC8100),
    "Đã giao": const Color(0xff831e8a),
    "Huỷ đơn": const Color(0xffBF1D28),
    "Trả hàng": const Color(0xffA6A6B0),
  };

  //background color
  Map<String, Color> statusBackgroundColor = {
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
    tabController = TabController(
        length: app_constants.trangThaiDonHangMap.length, vsync: this);

    //binding refreshController
    refreshController = List.generate(
        app_constants.trangThaiDonHangMap.length, (_) => RefreshController());

    //get load data
    getOrder(
        idTrangThaiDonHang:
            app_constants.trangThaiDonHangMap.values.toList()[0]);

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
    print(userId);

    //get order by idTaiKhoanMuaHang & idTrangThaiDonHang
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=$idTrangThaiDonHang&sortBy=created_at:desc",
      onSuccess: (value) {
        donHangResponse = value;
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
            idTrangThaiDonHang: app_constants.trangThaiDonHangMap.values
                .toList()[tabController!.index]);
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
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=${app_constants.trangThaiDonHangMap.values.toList()[tabController!.index]}&sortBy=created_at:desc",
      onSuccess: (value) {
        //check data is empty
        if (value.isEmpty) {
          refreshController[tabController!.index].loadNoData();
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
