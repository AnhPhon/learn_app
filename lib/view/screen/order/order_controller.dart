import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class OrderController extends GetxController {
  void onOrderWidgetClick() {
    Get.toNamed(AppRoutes.ORDER_DETAIL);
  }
}
