import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V2ShorthandedPaymentController extends GetxController
    with SingleGetTickerProviderMixin {
  String title = "Kết quả báo giá";

  bool isLoading = true;

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  // DonDichVuResponse idDonDichVu = DonDichVuResponse.fromJson({});
  DanhSachBaoGiaDonDichVuResponse danhSachBaoGiaDonDichVu =
      DanhSachBaoGiaDonDichVuResponse.fromJson({});

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['danhSachBaoGiaDonDichVu'] != null) {
      danhSachBaoGiaDonDichVu = arguments!['danhSachBaoGiaDonDichVu']
          as DanhSachBaoGiaDonDichVuResponse;
      print('danhSachBaoGiaDonDichVu ${danhSachBaoGiaDonDichVu.toJson()}');
      print(
          'danhSachBaoGiaDonDichVuxxx ${danhSachBaoGiaDonDichVu.idDonDichVu!.idTaiKhoan}');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void khongDongY() async {
    ///
    /// Pick multi images
    ///
    try {
      EasyLoading.show(status: 'Loading...');

      final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({
        'id': danhSachBaoGiaDonDichVu.idDonDichVu!.id.toString(),
      });
      donDichVuRequest.idTrangThaiDonDichVu = '617286fdf5c09a07f815e826';

      print('Model request ${donDichVuRequest.toJson()}');
      // load images
      donDichVuProvider.update(
        data: donDichVuRequest,
        onSuccess: (value) {
          EasyLoading.dismiss();
          update();
          Get.back(result: {'reload': true});
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  void dongY() async {
    final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({
      'id': danhSachBaoGiaDonDichVu.idDonDichVu!.id.toString(),
    });
    donDichVuRequest.idTrangThaiThanhToan = '61604f4cc8e6fa122227e29f';
    donDichVuRequest.idTrangThaiDonDichVu = '6170c6b6b3b6a47374f4e67a';

    double tienCoc = 0.05 *
        int.parse((danhSachBaoGiaDonDichVu.tongTien != null &&
                danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty)
            ? danhSachBaoGiaDonDichVu.tongTien.toString()
            : '0');
    Get.toNamed('${AppRoutes.ORDER_INFORMATION}?tienCoc=$tienCoc')!
        .then((value) {
              //đã thanh toán
              if (value != null && value['type'] == 1)
                {
                  donDichVuProvider.update(
                    data: donDichVuRequest,
                    onSuccess: (value) {
                      EasyLoading.dismiss();
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
  }

  void callToNumber() async {}
}
