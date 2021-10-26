import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';

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
      Alert.error(message: 'Vui lòng nhập số tiền');
    } else {
      EasyLoading.dismiss();
      Get.toNamed(
              "${AppRoutes.PAYMENT_RECHARGE}?soTienToiThieu=${amountOfMoneyController.text.replaceAll(RegExp(','), '')}&url=${AppRoutes.V1_WALLET}")!
          .then((value) {
        Get.offAllNamed(
          AppRoutes.V1_WALLET,
          predicate: ModalRoute.withName(AppRoutes.V1_WALLET),
        );
      });
    }
  }
}
