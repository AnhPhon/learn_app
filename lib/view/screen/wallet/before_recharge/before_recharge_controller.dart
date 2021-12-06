import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';

class BeforeRechargeController extends GetxController {
  //textEditingController
  final amountOfMoneyController = TextEditingController();

  //options
  List<String> optionList = [
    "100.000đ",
    "200.000đ",
    "500.000đ",
    "1.000.000đ",
    "2.000.000đ",
    "5.000.000đ",
  ];

  //title appbar
  String title = "Nạp tiền";

  //index selected
  int? indexSelected;

  //show or hide
  bool isShow = false;

  //balance
  String? balance;

  @override
  void onInit() {
    super.onInit();
    //get balance
    balance = Get.parameters['balance'];
  }

  @override
  void onClose() {
    amountOfMoneyController.dispose();
    super.onClose();
  }

  ///
  ///set show/hide
  ///
  void setShow() {
    isShow = !isShow;
    update();
  }

  ///
  ///set index selected
  ///
  void setIndexSelected({required int index}) {
    indexSelected = index;
    amountOfMoneyController.text = optionList[index].replaceAll('đ', '');
    update();
  }

  // void onChanged(BuildContext context, dynamic value) {
  //   amountOfMoneyController.text.replaceAllMapped(".", (match) => "");
  //   indexSelected = -1;
  //   update();
  // }

  ///
  ///btn recharge
  ///
  void onBtnRechargeClick() {
    //show loading
    EasyLoading.show(status: 'loading...');

    //validate
    if (amountOfMoneyController.text.isEmpty) {
      EasyLoading.dismiss();
      // show errors
      IZIAlert.error(message: 'Vui lòng nhập số tiền');
    } else {
      EasyLoading.dismiss();
      Get.toNamed(
              "${AppRoutes.PAYMENT_RECHARGE}?soTienToiThieu=${amountOfMoneyController.text.replaceAllMapped(".", (match) => "")}&noiDung=Nạp tiền vào ví")!
          .then(
        (value) {
          if (value != null && value['status'] == true) {
            Get.back(result: true);
          }
        },
      );
    }
  }
}
