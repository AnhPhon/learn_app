import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2WinningBidController extends GetxController {
  String title = "Bạn đã trúng thầu";

  ///
  ///payment
  ///
  void onPaymentClick() {
    Get.toNamed(AppRoutes.V2_PAYMENT_ORDER);
  }
}
