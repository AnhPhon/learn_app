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
  TabController? tabController;

  List<RefreshController>? refreshController;

  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangRequest donHangRequest = DonHangRequest();
  List<DonHangResponse> donHangResponse = [];

  Map<String, Color> statusColor = {
    "Xác nhận": const Color(0xff0D5BB5),
    "Chuẩn bị hàng": const Color(0xffCC8100),
    "Đang giao": const Color(0xff007D3A),
    "Đã giao": const Color(0xff16c7b5),
    "Huỷ đơn": const Color(0xffBF1D28),
    "Trả hàng": const Color(0xffc716be),
  };

  Map<String, Color> statusBackgroundColor = {
    "Xác nhận": const Color(0x1f0D5BB5),
    "Chuẩn bị hàng": const Color(0x1fCC8100),
    "Đang giao": const Color(0x1f007D3A),
    "Đã giao": const Color(0x1f16c7b5),
    "Huỷ đơn": const Color(0x1fBF1D28),
    "Trả hàng": const Color(0x1fc716be),
  };

  bool isLoading = true;
  bool isLoadingOrder = false;

  int pageMax = 1;
  int limitMax = 5;

  String userId = "";

  String title = "Quản lý đơn hàng";

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        length: app_constants.quanLyDonHangMap.length, vsync: this);
    refreshController = List.generate(
        app_constants.quanLyDonHangMap.length, (_) => RefreshController());
    getAllOrder();
    listenerTabController();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  ///
  ///get all order
  ///
  Future<void> getAllOrder({bool? isRefresh = true}) async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    if (isRefresh!) {
      pageMax = 1;
    } else {
      pageMax++;
    }

    //get all order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (orderAll) {
        if (orderAll.isEmpty) {
          refreshController![tabController!.index].loadNoData();
          update();
        } else {
          //remove at idTrangThaiDonHang.tieuDe == Mới tạo
          orderAll.removeWhere((element) =>
              element.idTrangThaiDonHang!.id == "616a39faea30f845b562876d");
          if (isRefresh) {
            donHangResponse = orderAll;
            refreshController![tabController!.index].refreshCompleted();
            update();
          } else {
            donHangResponse = donHangResponse.toList() + orderAll;
            refreshController![tabController!.index].loadComplete();
            update();
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///get order by idTaiKhoan & idTrangThaiDonHang
  ///
  void getOrder({required String idTrangThaiDonHang, bool? isRefresh = true}) {
    if (isRefresh!) {
      pageMax = 1;
    } else {
      pageMax++;
    }

    //get order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoan=$userId&idTrangThaiDonHang=$idTrangThaiDonHang&sortBy=created_at:desc",
      onSuccess: (order) {
        if (order.isEmpty) {
          refreshController![tabController!.index].loadNoData();
          update();
        } else {
          if (isRefresh) {
            donHangResponse = order;
            refreshController![tabController!.index].refreshCompleted();
            update();
          } else {
            donHangResponse = donHangResponse.toList() + order;
            refreshController![tabController!.index].loadComplete();
            update();
          }
        }

        isLoadingOrder = false;
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
        donHangResponse.clear();
        isLoadingOrder = true;
        update();

        if (tabController!.index == 0) {
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
    donHangResponse[index].idTrangThaiDonHang!.tieuDe = value.toString();
    update();
    donHangRequest.id = donHangResponse[index].id;
    donHangRequest.idTrangThaiDonHang =
        app_constants.trangThaiDonHangMap[value];
    donHangProvider.update(
      data: donHangRequest,
      onSuccess: (val) {
        if (tabController!.index != 0) {
          donHangResponse.clear();
          isLoadingOrder = true;
          update();
          getOrder(
              idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
                  .toList()[tabController!.index]);
        }
        print("=================Chuyển trạng thái thành công=================");
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  Future onRefresh() async {
    refreshController![tabController!.index].resetNoData();
    donHangResponse.clear();
    if (tabController!.index == 0) {
      getAllOrder();
    } else {
      //get product by idCategory
      getOrder(
          idTrangThaiDonHang: app_constants.quanLyDonHangMap.values
              .toList()[tabController!.index]);
    }
  }

  Future onLoading() async {
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
