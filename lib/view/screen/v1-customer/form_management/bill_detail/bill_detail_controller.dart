import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V1BillDetailController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  String title = "Thông tin đơn hàng";

  String note =
      "Đặt cọc đơn hàng (Chỉ đặt cọc nếu chưa thanh toán đơn hàng. Tiền này sẽ được khấu trừ khi thanh toán đơn hàng. Trường hợp thợ đã di chuyển đến nơi làm việc mà Khách hủy đơn thì Khách sẽ bị mất tiền cọc): ";

  double depositMoney = 0;
  double phiDichVu = 50000;
  double khuyenMaiCuaApp = 0;
  double giaTriDonHangMoney = 0;
  double tienCoc = 0;

  // TODO: phần trăm phí dịch vụ và tiền cọc
  double phiDichVuPhanTram = .02;
  double tienCocPhanTram = .10;

  DonDichVuResponse? idDonDichVu;
  double tongTien = 0;

  @override
  void onInit() {
    super.onInit();

    // Load dữ liệu từ arguments
    final List<double> _temps = Get.arguments[0] as List<double>;
    tongTien = _temps[0];
    phiDichVu = _temps[1];
    khuyenMaiCuaApp = _temps[2];
    idDonDichVu = Get.arguments[1] as DonDichVuResponse;

    depositMoney = tongTien * .1;

    loadThongTinThanhToan(tongTien);
  }

  ///
  /// get tong don hang
  ///
  double getTongDonHang() {
    return giaTriDonHangMoney + phiDichVu - khuyenMaiCuaApp;
  }

  ///
  /// load thông tin thanh toán
  ///
  void loadThongTinThanhToan(double giaTriDonHang) {
    giaTriDonHangMoney = giaTriDonHang;
    update();
  }

  void onContinueClick(DonDichVuResponse? donDichVu) {
    donDichVuProvider.update(
      data: DonDichVuRequest(
        id: donDichVu!.id,
        tienCoc: depositMoney.toString(),
        phiDichVu: phiDichVu.toString(),
        phiDichVuKhac: phiDichVu.toString(),
        tienCocKhac: depositMoney.toString(),
        khuyenMaiKhac: khuyenMaiCuaApp.toString(),
        idTrangThaiThanhToanKhac: DA_THANH_TOAN,
      ),
      onSuccess: (data) {},
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
    Get.toNamed(AppRoutes.V1_PAYMENT_METHOD,
            arguments: [donDichVu, Get.arguments[0] as List<double>])!
        .then(
      (value) {
        if (value != null) {
          donDichVuProvider.update(
            data: DonDichVuRequest(
              id: donDichVu.id,
              tongDon: tongTien.toString(),
              khuyenMai: khuyenMaiCuaApp.toString(),
              phiDichVu: phiDichVu.toString(),
              phiDichVuKhac: phiDichVu.toString(),
              tienCocKhac: depositMoney.toString(),
              khuyenMaiKhac: khuyenMaiCuaApp.toString(),
              idTrangThaiThanhToanKhac: DA_THANH_TOAN,
            ),
            onSuccess: (data) {},
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        }
      },
    );
  }
}
