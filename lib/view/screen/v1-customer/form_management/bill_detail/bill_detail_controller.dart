import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1BillDetailController extends GetxController {
  String title = "Thông tin đơn hàng";

  String note =
      "Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di chuyển đến nơi làm việc mà Khách hủy đơn thì Khách sẽ bị mất tiền cọc): ";

  double depositMoney = 1000000;
  double phiDichVu = 50000;
  double khuyenMaiCuaApp = 0;
  double giaTriDonHangMoney = 0;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().giaTriDonHang.then((giaTriDonHang) {
      giaTriDonHangMoney = giaTriDonHang!;
      update();
    });
  }

  ///
  /// get tong don hang
  ///
  double getTongDonHang() {
    return giaTriDonHangMoney + phiDichVu - khuyenMaiCuaApp;
  }

  void onContinueClick() {
    Get.toNamed(AppRoutes.V1_PAYMENT_METHOD);
  }
}
