import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1BeforeRechargeController extends GetxController {
  //textEditingController
  final amountOfMoneyController = TextEditingController();

  //options
  List optionList = [
    "100,000",
    "200,000",
    "500,000",
    "1,000,000",
    "2,000,000",
    "5,000,000",
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
    super.onClose();
    amountOfMoneyController.dispose();
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
    amountOfMoneyController.text = optionList[index].toString();
    update();
  }

  void onChanged(BuildContext context, dynamic value) {
    amountOfMoneyController.text.replaceAll(",", "");
    indexSelected = -1;
    update();
  }

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
      Get.snackbar(
        "Lỗi", // title
        "Vui lòng nhập sô tiền", // message
        icon: const Icon(Icons.error_outline),
        backgroundColor: const Color(0xffFFCDD2),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
    } else {
      EasyLoading.dismiss();
      Get.toNamed(
          "${AppRoutes.V1_RECHARGE}?amountOfMoney=${amountOfMoneyController.text.replaceAll(RegExp(','), '')}");
    }
  }
}
