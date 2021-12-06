import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';

class V2QuotationG56Controller extends GetxController {
  final contentController = TextEditingController();
  final MoneyMaskedTextController quotationController = MoneyMaskedTextController(
    precision: 0,
    initialValue: 0.0,
    decimalSeparator: '',
  );

  String title = "Báo giá theo thông tin khách hàng";
  String idDonDichVu = "";

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest = DanhSachBaoGiaDonDichVuRequest.fromJson({});

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null && arguments['donDichVu'] != null) {
      idDonDichVu = arguments!['id'] as String;
      donDichVuResponse = arguments!['donDichVu'] as DonDichVuResponse;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;
    }
  }

  ///
  /// Get price of unit
  ///
  String getPriceValue() {
    return Validate.getValuePriceString(quotationController.text);
  }

  ///
  /// Dong y bao gia
  ///
  Future<void> onDoneClick() async {
    try {
      EasyLoading.show(status: 'Loading...');

      if (await checkForm()) {
        danhSachBaoGiaDonDichVuProvider.add(
          data: danhSachBaoGiaDonDichVuRequest,
          onSuccess: (data) {
            EasyLoading.dismiss();
            IZIAlert.success(message: 'Báo giá thành công');
            Get.back();
            Get.back();
          },
          onError: (error) {
            EasyLoading.dismiss();
            print('V2QuotationG56Controller onDoneClick onError $error');
            IZIAlert.error(message: 'Báo giá thất bại');
          },
        );
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
      print('V2QuotationG56Controller onDoneClick onError $e');
    }
  }

  ///
  /// Validate form input
  ///
  Future<bool> checkForm() async {
    if (quotationController.text.isEmpty || quotationController.text == 'null'|| quotationController.text == '0') {
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Không được bỏ trống giá trị đơn hàng');
      return false;
    } else if (contentController.text.isEmpty || contentController.text == 'null') {
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Không được bỏ trống nội dung báo giá');
      return false;
    } else {
      danhSachBaoGiaDonDichVuRequest.tongTien = Validate.getValuePriceString(quotationController.text);
      danhSachBaoGiaDonDichVuRequest.ghiChu = contentController.text;
    }

    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;

    return true;
  }

}
