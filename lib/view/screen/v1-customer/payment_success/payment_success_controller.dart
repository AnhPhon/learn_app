import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1PaymentSuccessController extends GetxController {
  String title = "Thông báo thành công";

  bool? isBuy;
  bool? isInsurance;

  @override
  void onInit() {
    super.onInit();
    isBuy = Get.parameters['isBuy'] == "true";
    isInsurance = Get.parameters['isInsurance'] == "true";
  }

  ///
  ///go to home
  ///
  void onCompleteClick() {
    Get.offAllNamed(AppRoutes.V1_DASHBOARD,
        predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
  }
}
