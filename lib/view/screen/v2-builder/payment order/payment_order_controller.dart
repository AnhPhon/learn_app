import 'package:get/get.dart';

class V2PaymentOrderController extends GetxController {
  String title = "Thanh toán đơn hàng";

  ///
  ///cancel
  ///
  void onCancleClick() {
    Get.back();
  }

  ///
  ///go to payment account page
  ///
  void onCheckoutClick() {
    // Get.toNamed("${AppRoutes.V2_PAYMENT_METHOD}?isBuy=false");
  }
}
