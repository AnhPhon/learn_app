import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';

class VoucherController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo discount code
  String discountCode = "ABCDDDD";

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
  ///Copy discount code
  ///
  void copyDiscountCode({required String content}) {
    Clipboard.setData(ClipboardData(text: content));
    IZIAlert.success(message: 'Copy mã giảm giá $content thành công');
  }
}
