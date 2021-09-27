import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OrderController extends GetxController with SingleGetTickerProviderMixin {
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  bool isLoading = true;

  List<OrderModel> orderList = [];

  List<List<OrderModel>> orderStatusList = [[], [], [], [], []];

  int indexTab = 0;

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
    "4": const Color(0xffBF1D28),
    "5": const Color(0xffA6A6B0),
  };

  Map<String, Color> statusBackgroundColor = {
    "1": const Color(0x1f007D3A),
    "2": const Color(0x1f0D5BB5),
    "3": const Color(0x1fCC8100),
    "4": const Color(0x1fBF1D28),
    "5": const Color(0x1fA6A6B0),
  };

  String? userId;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getOrderbyIdUser();
    });
    indexTab = int.parse(Get.parameters['indexTab'].toString());
    update();
    print(Get.parameters['indexTab']);
  }

  ///
  ///get order by id user
  ///
  void getOrderbyIdUser() {
    sl
        .get<SharedPreferenceHelper>()
        .userId
        .then((value) => orderProvider.paginate(
            page: 1,
            limit: 100,
            filter: "&idUser=$value",
            onSuccess: (value) {
              orderList = value;
              value.forEach((element) {
                if (element.statusOrder != "0") {
                  orderStatusList[int.parse(element.statusOrder!) - 1]
                      .add(element);
                }
              });
              update();
            },
            onError: (error) {
              print(error);
            }));
  }

  void onOrderWidgetClick() {
    Get.toNamed(AppRoutes.ORDER_DETAIL);
  }
}
