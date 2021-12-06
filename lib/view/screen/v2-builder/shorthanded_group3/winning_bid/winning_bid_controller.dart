import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V2WinningBidController extends GetxController {
  String title = "Bạn đã trúng thầu";

  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});
  
  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      donDichVuResponse = arguments!['donDichVuResponse'] as DonDichVuResponse;
    }

    Future.delayed(Duration.zero, () {});
  }

  ///
  ///payment
  ///
  void onPaymentClick() {
    try {

      final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({
        'id': idDonDichVu.toString(),
      });

      donDichVuRequest.idTrangThaiThanhToanKhac = DAT_COT; // TODO: Check lai logic cho nay cos 2 trang thai da thanh toan va dat coc nhan viec
      donDichVuRequest.idTrangThaiDonDichVu = TRUNG_THAU;

      final double soTien = 1.0 * int.parse((donDichVuResponse.soTien != null && donDichVuResponse.soTien!.isNotEmpty) ? donDichVuResponse.soTien.toString() : '0');
      final double tienCoc = 0.05 * int.parse((donDichVuResponse.soTien != null && donDichVuResponse.soTien!.isNotEmpty) ? donDichVuResponse.soTien.toString() : '0');

      Get.toNamed('${AppRoutes.V2_PAYMENT_ORDER}?soTien=$soTien&tienCoc=$tienCoc&noiDung=Thanh toán đơn dịch vụ')!.then((value) {
        //đã thanh toán
        if (value != null && value['type'] == 1) {

          donDichVuRequest.tienCocKhac = tienCoc.toString();
          donDichVuRequest.khuyenMaiKhac = value['khuyenMai'].toString();
          donDichVuRequest.phiDichVuKhac = value['phiDichVu'].toString();

          donDichVuProvider.update(
            data: donDichVuRequest,
            onSuccess: (value) {
              EasyLoading.dismiss();
              Alert.success(message: "Nhận việc thành công");
              update();
              Get.back(result: {'reload': true});
            },
            onError: (e) {
              EasyLoading.dismiss();
              Alert.error(message: e.toString());
            },
          );
        }
      });

    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }
}
