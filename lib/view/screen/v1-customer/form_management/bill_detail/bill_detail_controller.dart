import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1BillDetailController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  String title = "Thông tin đơn hàng";

  String note =
      "Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di chuyển đến nơi làm việc mà Khách hủy đơn thì Khách sẽ bị mất tiền cọc): ";

  double depositMoney = 1000000;
  double phiDichVu = 50000;
  double khuyenMaiCuaApp = 0;
  double giaTriDonHangMoney = 0;

  // TODO: phần trăm phí dịch vụ và tiền cọc
  double phiDichVuPhanTram = .02;
  double tienCocPhanTram = .10;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().giaTriDonHang.then((giaTriDonHang) {
      if (giaTriDonHang != null) {
        depositMoney = giaTriDonHang * tienCocPhanTram;
        phiDichVu = giaTriDonHang * phiDichVuPhanTram;
        giaTriDonHangMoney = giaTriDonHang;
      }

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
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      print(workFlowId);
      donDichVuProvider.update(
        data: DonDichVuRequest(
          id: workFlowId,
          tienCoc: depositMoney.toString(),
          phiDichVu: phiDichVu.toString(),
        ),
        onSuccess: (data) {},
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
    Get.toNamed(AppRoutes.V1_PAYMENT_METHOD);
  }
}
