import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V2AfterQuotationG2Controller extends GetxController {
  File? image;
  List<File> imageList = [];

  String title = "Báo giá";

  List<String> quotationInfo = [
    "Khách hàng cung cấp thông tin",
    "Đến hiện trường",
  ];

  String idDonDichVu = "";
  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest = DanhSachBaoGiaDonDichVuRequest.fromJson({});
  int orderValue = 0;
  List<ChiTietCongViecRequest> chiTietCongViecRequest = [ChiTietCongViecRequest.fromJson({})];
  ChiTietCongViecProvider chiTietCongViecProvider = GetIt.I.get<ChiTietCongViecProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  //unit price string arrray
  List<String> unitPrices = ['0'];

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null) {
      if (arguments['id'] != null) {
        idDonDichVu = arguments!['id'] as String;
      }
      if (arguments['chiTietCongViecRequest'] != null) {
        chiTietCongViecRequest = arguments!['chiTietCongViecRequest'] as List<ChiTietCongViecRequest>;
      }
      if (arguments['danhSachBaoGiaDonDichVuRequest'] != null) {
        danhSachBaoGiaDonDichVuRequest = arguments!['danhSachBaoGiaDonDichVuRequest'] as DanhSachBaoGiaDonDichVuRequest;
      }
      if (arguments['unitPrices'] != null) {
        unitPrices = arguments!['unitPrices'] as List<String>;
      }
      // print('danhSachBaoGiaDonDichVuRequest ${danhSachBaoGiaDonDichVuRequest}');
      // print('danhSachBaoGiaDonDichVuRequest.tongTien ${danhSachBaoGiaDonDichVuRequest.tongTien}');
      update();
    }

  }

  ///
  /// Dinh dang ten file da upload
  ///
  String getFileNameBaoGia() {
    if (danhSachBaoGiaDonDichVuRequest.file != null && danhSachBaoGiaDonDichVuRequest.file!.isNotEmpty && danhSachBaoGiaDonDichVuRequest.file.toString() != 'null') {
      final arrayNameSplit = danhSachBaoGiaDonDichVuRequest.file.toString().split('/');
      return arrayNameSplit[arrayNameSplit.length - 1];
    }
    return '';
  }

  ///
  ///on btn edit click
  ///
  void onBtnEditClick() {
    Get.back();
  }

  ///
  /// Validate form input
  ///
  Future<bool> checkForm() async {
    danhSachBaoGiaDonDichVuRequest.giaCongViecs = [];
    for (var i = 0; i < chiTietCongViecRequest.length; i++) {

      print(chiTietCongViecRequest[i]);
      print('tenCongViec ${chiTietCongViecRequest[i].tenCongViec}');
      print('donGia ${chiTietCongViecRequest[i].donGia}');
      print('donVi ${chiTietCongViecRequest[i].donVi}');
      print('idDonDichVu ${chiTietCongViecRequest[i].idDonDichVu}');

      await chiTietCongViecProvider.add(
        data: chiTietCongViecRequest[i],
        onSuccess: (data) {
          danhSachBaoGiaDonDichVuRequest.giaCongViecs!.add(GiaCongViecRequest.fromJson({
            'idChiTietCongViec': data.id,
            'donGia': unitPrices[i],
          }));
        },
        onError: (error) {
          print('V2QuotationG2Controller checkForm onError $error');
          IZIAlert.error(message: error.toString());
        },
      );
    }
    danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    // danhSachBaoGiaDonDichVuRequest.tongTien = orderValue.toString();
    danhSachBaoGiaDonDichVuRequest.giaVatTus = [];

    return true;
  }

  ///
  ///on btn send click
  ///
  Future<void> onBtnSendClick() async {
    // Get.offNamed(AppRoutes.V2_SHORTHANDED);

    try {
      EasyLoading.show(status: 'Loading...');

      if (await checkForm()) {
        print('danhSachBaoGiaDonDichVuRequest $danhSachBaoGiaDonDichVuRequest');
        EasyLoading.dismiss();
        danhSachBaoGiaDonDichVuProvider.add(
          data: danhSachBaoGiaDonDichVuRequest,
          onSuccess: (data) {
            EasyLoading.dismiss();
            IZIAlert.success(message: 'Báo giá thành công');
            Get.back();
            Get.back();
          },
          onError: (error) {
            print('V2QuotationG1Controller onDoneClick onError $error');
            EasyLoading.dismiss();
            IZIAlert.error(message: 'Báo giá thất bại');
          },
        );
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }
}
