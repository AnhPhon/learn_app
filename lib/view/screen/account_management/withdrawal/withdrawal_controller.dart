import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_number.dart';

class WithdrawalController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo bool obscure
  bool obscure = true;

  //Khai báo số dư tài khoản
  String accountBalance = "20000000000";

  //Khai báo obscure
  String obscureCharacters = "************";

  //Khai báo sô tiền ở ví
  MoneyMaskedTextController walletBalanceController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
  );

  //Khai báo list default amount
  List<String> defaultAmountList = [
    "100.000đ",
    "200.000đ",
    "500.000đ",
  ];

  //Khai báo số tiền rút
  String? withdrawalAmount;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    walletBalanceController.dispose();
    super.onClose();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedIsVisible() {
    obscure = false;
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedNoVisible() {
    obscure = true;
    update();
  }

  ///
  /// OnTap set Default Amount
  ///
  void setDefaultAmount({required int index}) {
    if (index == 0) {
      print("100000");
    } else if (index == 1) {
      print("200000");
    } else if (index == 2) {
      print("500000");
    }
    update();
  }
}
