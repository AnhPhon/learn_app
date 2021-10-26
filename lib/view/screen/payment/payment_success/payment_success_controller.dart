import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class PaymentSuccessController extends GetxController {
  String title = "Thông báo thành công";

  bool isPayment = false;
  @override
  void onInit() {
    super.onInit();
    //check trạng thái thanh toán thành công
    if (Get.parameters['isPayment'] != null &&
        Get.parameters['isPayment'] == '0') {
      isPayment = true;
    } else {
      isPayment = false;
    }
    update();
  }

  ///
  ///go to home
  ///
  void onCompleteClick() {
    Get.back(result: true);
  }
}
