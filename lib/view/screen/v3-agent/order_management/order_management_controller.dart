import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V3OrderManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  //tabController
  TabController? tabController;

  // refresh controller for load more refresh
  List<RefreshController>? refreshController;

  //DonHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangRequest donHangRequest = DonHangRequest();
  List<DonHangResponse> donHangResponse = [];

  //text color
  Map<String, Color> statusColor = {
    "Xác nhận": const Color(0xff0D5BB5),
    "Chuẩn bị hàng": const Color(0xffCC8100),
    "Đang giao": const Color(0xff007D3A),
    "Đã giao": const Color(0xff16c7b5),
    "Huỷ đơn": const Color(0xffBF1D28),
    "Trả hàng": const Color(0xffc716be),
  };

  //background color
  Map<String, Color> statusBackgroundColor = {
    "Xác nhận": const Color(0x1f0D5BB5),
    "Chuẩn bị hàng": const Color(0x1fCC8100),
    "Đang giao": const Color(0x1f007D3A),
    "Đã giao": const Color(0x1f16c7b5),
    "Huỷ đơn": const Color(0x1fBF1D28),
    "Trả hàng": const Color(0x1fc716be),
  };

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingOrder = false;

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //user id
  String userId = "";

  //title appbar
  String title = "Quản lý đơn hàng";

  @override
  void onInit() {
    super.onInit();
    //binding tabController
    tabController = TabController(
        length: app_constants.quanLyDonHangMap.length, vsync: this);

    //binding refreshController
    refreshController = List.generate(
        app_constants.quanLyDonHangMap.length, (_) => RefreshController());

    //get load data
    getAllOrder();

    //lstener tabController
    listenerTabController();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
    refreshController!.clear();
  }

  ///
  ///get all order
  ///
  Future<void> getAllOrder({bool? isRefresh = true}) async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //isRefresh
    if (isRefresh!) {
      pageMax = 1;
      donHangResponse.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get all order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (orderAll) {
        //check is empty
        if (orderAll.isEmpty) {
          refreshController![tabController!.index].loadNoData();
          update();
        } else {
          //remove at idTrangThaiDonHang.tieuDe == Mới tạo
          orderAll.removeWhere((element) =>
              element.idTrangThaiDonHang!.id == "616a39faea30f845b562876d");

          //isRefresh
          if (isRefresh) {
            donHangResponse = orderAll;
            refreshController![tabController!.index].refreshCompleted();
          } else {
            //is load more
            donHangResponse = donHangResponse.toList() + orderAll;
            refreshController![tabController!.index].loadComplete();
          }
        }

        isLoading = false;
        isLoadingOrder = false;
        update();
      },
      onError: (error) {
        print("V3OrderManagementController getAllOrder onError $error");
      },
    );
  }

  ///
  ///get order by idTaiKhoan & idTrangThaiDonHang
  ///
  void getOrder({required String idTrangThaiDonHang, bool? isRefresh = true}) {
    //isRefresh
    if (isRefresh!) {
      pageMax = 1;
      donHangResponse.clear();
    } else {
      //is load more
      pageMax++;
    }

    //get order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoan=$userId&idTrangThaiDonHang=$idTrangThaiDonHang&sortBy=created_at:desc",
      onSuccess: (order) {
        //check is empty
        if (order.isEmpty) {
          refreshController![tabController!.index].loadNoData();
        } else {
          //isRefresh
          if (isRefresh) {
            donHangResponse = order;
            refreshController![tabController!.index].refreshCompleted();
          } else {
            //is load more
            donHangResponse = donHangResponse.toList() + order;
            refreshController![tabController!.index].loadComplete();
          }
        }

        isLoadingOrder = false;
        update();
      },
      onError: (error) {
        print("V3OrderManagementController getOrder onError $error");
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
        isLoadingOrder = true;
        update();

        //check tabController index
        if (tabController!.index == 0) {
          //get all order
          getAllOrder();
        } else {
          //get product by idCategory
          getOrder(
              idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
                  .toList()[tabController!.index]);
        }
      }
    });
  }

  ///
  ///onChanged dropdown
  ///
  void onChangedDropdown({String? value, required int index}) {
    //set value dropdown
    donHangResponse[index].idTrangThaiDonHang!.tieuDe = value.toString();
    update();

    //set data
    donHangRequest.id = donHangResponse[index].id;
    donHangRequest.idTrangThaiDonHang =
        app_constants.trangThaiDonHangMap[value];

    //update status order
    donHangProvider.update(
      data: donHangRequest,
      onSuccess: (val) {
        //check tabController index if != 0 then reload initial tab
        if (tabController!.index != 0) {
          donHangResponse.clear();
          isLoadingOrder = true;
          update();

          //reload initial tab
          getOrder(
              idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
                  .toList()[tabController!.index]);
        }
        print("=================Chuyển trạng thái thành công=================");
      },
      onError: (error) {
        print("V3OrderManagementController onChangedDropdown onError $error");
      },
    );
  }

  ///
  ///on resfresh
  ///
  Future onRefresh() async {
    //reset nodata
    refreshController![tabController!.index].resetNoData();

    //check tabController index
    if (tabController!.index == 0) {
      getAllOrder();
    } else {
      //get product by idCategory
      getOrder(
          idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
              .toList()[tabController!.index]);
    }
  }

  ///
  ///on loading
  ///
  Future onLoading() async {
    //check tabController index
    if (tabController!.index == 0) {
      getAllOrder(isRefresh: false);
    } else {
      //get product by idCategory
      getOrder(
        idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
            .toList()[tabController!.index],
        isRefresh: false,
      );
    }
  }
}
