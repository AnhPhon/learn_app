import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3PaymentAccountController extends GetxController {
  String title = "Tài khoản của bạn";

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.V3_PAYMENT_SUCCESS);
  }

  ///
  ///go to recharge
  ///
  void onRechargeClick() {
    Get.toNamed(AppRoutes.V3_RECHARGE);
  }
}
