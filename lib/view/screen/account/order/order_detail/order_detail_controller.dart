import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class OrderDetailController extends GetxController {
  List payment = ["Giá tiền", "Phí ship", "Khuyến mãi", "Tổng"];
  List price = ["150.000đ", "15.000đ", "-50.000đ", "115.000đ"];

  void onHistoryClick() {
    Get.toNamed(AppRoutes.HISTORY);
  }
}
