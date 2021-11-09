import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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

class V2ShorthandedPaymentController extends GetxController with SingleGetTickerProviderMixin {

  String title = "Thông tin khách hàng";

  bool isLoading = true;

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonDichVuResponse idDonDichVu = DonDichVuResponse.fromJson({});

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idDonDichVu'] != null) {

      idDonDichVu = arguments!['idDonDichVu'] as DonDichVuResponse;
      print('idDonDichVu ${idDonDichVu.toJson()}');
      print('idTaiKhoanxxx ${idDonDichVu.idTaiKhoan}');
    }

  }

  @override
  void onClose() {
    super.onClose();
  }

  void callToNumber() async {
    if(idDonDichVu.idTaiKhoan == null || idDonDichVu.idTaiKhoan!.soDienThoai == null || idDonDichVu.idTaiKhoan!.soDienThoai!.isEmpty  || idDonDichVu.idTaiKhoan!.soDienThoai == 'null' ) {
      Alert.error(message: 'Số điện thoại không khả dụng');
    } else {
      await FlutterPhoneDirectCaller.callNumber(idDonDichVu.idTaiKhoan!.soDienThoai.toString());
    }
  }

}
