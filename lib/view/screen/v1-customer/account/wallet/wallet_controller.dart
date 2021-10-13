import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v1-customer/account/wallet/wallet_page.dart';

class V1WalletController extends GetxController {
  String title = "Ví của bạn";

  bool isShow = false;

  List<History> historyList = [
    History(dateTime: "THÁNG 09/2021", itemHistory: [
      ItemHistory(
        id: "2123123FGS4312",
        price: "+500.000đ",
        content: "Nội dung thanh toán",
        time: "26/09 15:30",
        status: 1,
      ),
      ItemHistory(
        id: "2123123FGS4312",
        price: "+10.000đ",
        content: "Nội dung thanh toán",
        time: "26/09 15:30",
        status: 0,
      ),
      ItemHistory(
        id: "2123123FGS4312",
        price: "+10.000.000đ",
        content: "Nội dung thanh toán",
        time: "26/09 15:30",
        status: 1,
      ),
    ]),
    History(
      dateTime: "THÁNG 08/2021",
      itemHistory: [
        ItemHistory(
          id: "2123123FGS4312",
          price: "+1.000.000đ",
          content: "Nội dung thanh toán",
          time: "26/09 15:30",
          status: 1,
        )
      ],
    ),
  ];

  ///
  ///set show/hide
  ///
  void setShow() {
    isShow = !isShow;
    update();
  }

  ///
  ///recharge
  ///
  void onRecharge() {
    Get.toNamed(AppRoutes.V1_BEFORE_RECHARGE);
  }
}
