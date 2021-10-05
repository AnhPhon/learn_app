import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1BillDetailController extends GetxController {
  String title = "Thông tin đơn hàng";

  String note =
      "Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di chuyển đến nơi làm việc mà Khách hủy đơn thì Khách sẽ bị mất tiền cọc): ";

  String deposit = " 1.000.000 VND";

  void onContinueClick() {
    Get.toNamed(AppRoutes.V1_PAYMENT_METHOD);
  }
}
