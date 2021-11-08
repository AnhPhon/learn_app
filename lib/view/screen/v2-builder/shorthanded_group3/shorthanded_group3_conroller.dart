import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V2ShorthandedGroup3Controller extends GetxController {
  String title = "Công việc đang cần người";

  String idDonDichVu = '';

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
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      title = arguments!['title'] as String;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;
      print('idDonDichVu $idDonDichVu title $title');
      getDetailDonDichVu();
    }

    Future.delayed(Duration.zero, () {});
  }

  /// Lay chi tiet don dich vu
  void getDetailDonDichVu() {
    donDichVuProvider.find(
      id: idDonDichVu.toString(),
      onSuccess: (data) {
        donDichVuResponse = data;
        print(
            'V2ShorthandedGroup1Controller getDetailDonDichVu onSuccess ${donDichVuResponse.toJson()}');
        // print('V2ShorthandedGroup1Controller getDetailDonDichVu onSuccess ${donDichVuResponse!.idBangGiaDonHang!.toJson()}');
        update();
        // getListChiTietCongViec();
      },
      onError: (error) {
        print(
            'V2ShorthandedGroup1Controller getDetailDonDichVu onError $error');
      },
    );
  }

  ///
  /// Dinh dang ngay thang nam
  ///
  String getDateOutput(String dateString) {
    if (dateString.isEmpty || dateString == 'null') return '';
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }

  ///
  ///accept
  ///
  void onAcceptClick() async {
    try {
      EasyLoading.show(status: 'Loading...');

      danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia =
          await sl.get<SharedPreferenceHelper>().userId;

      danhSachBaoGiaDonDichVuProvider.add(
        data: danhSachBaoGiaDonDichVuRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Alert.success(message: 'Báo giá thành công');
          Get.back();
        },
        onError: (error) {
          print('V2QuotationG56Controller onDoneClick onError $error');
          EasyLoading.dismiss();
          Alert.error(message: 'Báo giá thất bại');
        },
      );
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
    // Get.toNamed(AppRoutes.V2_WINNING_BID);
  }
}
