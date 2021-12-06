import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V3ThanhToanPhiDichVuController extends GetxController
    with SingleGetTickerProviderMixin {
  String title = "Thanh toán phí dịch vụ";
  String idDonDichVu = "";
  double phiDichVuApp = 110000;
  double khuyenMaiApp = 50000;

  double tien = 0;
  double canThanhToan = 0;

  List<double> args = [];
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  @override
  void onInit() {
    super.onInit();
    args = Get.arguments[0] as List<double>;
    tien = args[0];
    khuyenMaiApp = args[1];
    phiDichVuApp = args[2];
    idDonDichVu = Get.arguments[1] as String;
    canThanhToan = phiDichVuApp - khuyenMaiApp;

    update();
  }

  ///
  /// onTaiKhoanCuaBanClick
  ///
  void onTaiKhoanCuaBanClick() {
    Get.toNamed(
            '${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${canThanhToan.toStringAsFixed(0)}&noiDung=Thanh toán đơn dịch vụ')!
        .then((value) {
      donDichVuProvider.find(
        id: idDonDichVu.toString(),
        onSuccess: (data) {
          donDichVuProvider.update(
              data: DonDichVuRequest(
                id: data.id,
                idTrangThaiDonDichVu: TRUNG_THAU,
              ),
              onSuccess: (data) {
                Get.back();
                Get.back();
              },
              onError: (error) {
                print(
                    "V3DaPhanHoiController onThanhToanPhiDichVuClick onError $error");
              });
        },
        onError: (error) {
          print(
              "V3DaPhanHoiController onThanhToanPhiDichVuClick onError $error");
        },
      );
    });
  }
}
