import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/account_management_routers.dart';

class AccountManagementController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo sô tiền ở ví
  MoneyMaskedTextController walletBalanceController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
  );

  //Khai báo Smart Refresher controller
  RefreshController refreshController = RefreshController(
    initialLoadStatus: LoadStatus.loading,
  );

  //Khai báo số dư tài khoản
  String accountBalance = "20000000";

  //Khai báo obscure
  String obscureCharacters = "************";

  //Khai báo bool obscure
  bool obscure = true;

  //Khai báo isEnable Button
  bool isEnableButton = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    obscure = true;
    isEnableButton = true;
    walletBalanceController.updateValue(20000000);
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
  ///Go to Withdrawal
  ///
  void goToWithdrawal() {
    Get.toNamed(AccountManagementRouter.WITHDRAWAL)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        onInit();
        update();
      }
    });
    update();
  }

  ///
  ///Go to Recharge
  ///
  void goToRecharge() {
    Get.toNamed(AccountManagementRouter.RECHARGE)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        onInit();
        update();
      }
    });
    update();
  }

  ///
  ///On Refresher
  ///
  Future<void> onRefresh() async {
    //resetNoData
    refreshController.resetNoData();
    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshController.refreshCompleted();
    });
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading() async {
    //get order isLoading
  }
}
