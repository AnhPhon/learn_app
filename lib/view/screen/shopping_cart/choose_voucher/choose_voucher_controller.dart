import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_alert.dart';

class ChooseVoucherController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo discount code
  String discountCode = "ABCDDDD";

  //Khai báo isCheckBox
  bool isCheckBox = false;

  //Khai báo Smart Refresher controller
  RefreshController refreshController = RefreshController(
    initialLoadStatus: LoadStatus.loading,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///On changed Checkbox
  ///
  void onChanged(int index, {required bool val}) {
    isCheckBox = val;
    update();
  }

  ///
  ///Copy discount code
  ///
  void copyDiscountCode({required String content}) {
    Clipboard.setData(ClipboardData(text: content));
    IZIAlert.success(message: 'Copy mã giảm giá $content thành công');
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
