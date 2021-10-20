import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V3OrderManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  List<DonHangResponse> donHangResponse = [];

  Map<String, String> statusPayment = {
    "1": "Chưa thanh toán",
    "2": "Đã thanh toán",
  };
  Map<String, String> statusLabel = {
    "1": "Mới tạo",
    "2": "Đang xử lý",
    "3": "Đã vận chuyển",
    "4": "Đã giao hàng",
    "5": "Hủy đơn",
  };
  Map<String, Color> statusColor = {
    "1": const Color(0xff007D3A),
    "2": const Color(0xff0D5BB5),
    "3": const Color(0xffCC8100),
    "4": const Color(0xffA6A6B0),
    "5": const Color(0xffBF1D28),
  };

  Map<String, Color> statusBackgroundColor = {
    "1": const Color(0x1f007D3A),
    "2": const Color(0x1f0D5BB5),
    "3": const Color(0x1fCC8100),
    "4": const Color(0x1fA6A6B0),
    "5": const Color(0x1fBF1D28),
  };

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  List<OderManagement> orderList = [
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "1",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "2",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "3",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "4",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "5",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
  ];

  bool isLoading = true;
  // bool isLoadingOrder = true;

  int pageMax = 1;
  int limitMax = 5;

  String userId = "";

  String title = "Quản lý đơn hàng";

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        length: app_constants.quanLyDonHangMap.length, vsync: this);
    getAllOrder();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  ///
  ///get all order
  ///
  Future<void> getAllOrder() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get all order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (orderAll) {
        if (orderAll.isNotEmpty) {
          donHangResponse = orderAll;
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
  void getOrder({required String idTrangThaiDonHang}) {
    //get order
    donHangProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter:
          "&idTaiKhoan=$userId&idTrangThaiDonHang=$idTrangThaiDonHang&sortBy=created_at:desc",
      onSuccess: (order) {
        if (order.isNotEmpty) {
          donHangResponse = order;
        }
        // isLoadingOrder = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}

class OderManagement {
  String id;
  String statusOrder;
  String image;
  String dateTime;
  OderManagement(
      {required this.id,
      required this.statusOrder,
      required this.image,
      required this.dateTime});
}
