import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2QuotationG56Controller extends GetxController {
  final contentController = TextEditingController();
  final quotationController = TextEditingController();

  String title = "Báo giá theo thông tin khách hàng";
  String idDonDichVu = "";

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest =
      DanhSachBaoGiaDonDichVuRequest.fromJson({});

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null &&
        arguments['id'] != null &&
        arguments['donDichVu'] != null) {
      idDonDichVu = arguments!['id'] as String;
      donDichVuResponse = arguments!['donDichVu'] as DonDichVuResponse;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;
      print('idDonDichVu $idDonDichVu title $title');
    }

  }

  String getPriceValue() {
    return (quotationController.text == null ||
            quotationController.text.isEmpty ||
            quotationController.text == 'null')
        ? '0'
        : quotationController.text;
  }

  void onDoneClick() async {
    try {
      EasyLoading.show(status: 'Loading...');

      if (await checkForm()) {
        danhSachBaoGiaDonDichVuProvider.add(
          data: danhSachBaoGiaDonDichVuRequest,
          onSuccess: (data) {
            EasyLoading.dismiss();
            Alert.success(message: 'Báo giá thành công');
            Get.back();
            Get.back();
          },
          onError: (error) {
            print('V2QuotationG56Controller onDoneClick onError $error');
            Alert.error(message: 'Báo giá thất bại');
          },
        );
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Validate form input
  ///
  Future<bool> checkForm() async {
    if (quotationController.text.isEmpty ||
        quotationController.text.isEmpty == 'null') {
      EasyLoading.dismiss();
      Alert.error(message: 'Không được bỏ trống giá trị đơn hàng');
      return false;
    } else if (contentController.text.isEmpty ||
        contentController.text.isEmpty == 'null') {
      EasyLoading.dismiss();
      Alert.error(message: 'Không được bỏ trống nội dung báo giá');
      return false;
    } else {
      danhSachBaoGiaDonDichVuRequest.tongTien = quotationController.text;
      danhSachBaoGiaDonDichVuRequest.ghiChu = contentController.text;
    }

    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia =
        await sl.get<SharedPreferenceHelper>().userId;

    return true;
  }
}
