import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup6Controller extends GetxController {
  String title = "Dịch vụ đang cần báo giá";

  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVuResponse;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      title = arguments!['title'] as String;

      print('idDonDichVu $idDonDichVu title $title');
      getDetailDonDichVu();
    }

    Future.delayed(Duration.zero, () {});
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Lay chi tiet don dich vu
  void getDetailDonDichVu() {
    donDichVuProvider.find(
      id: idDonDichVu.toString(),
      onSuccess: (data) {
        donDichVuResponse = data;
        print(
            'V2ShorthandedGroup1Controller getDetailDonDichVu onSuccess ${donDichVuResponse!.toJson()}');
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
  ///on btn edit click
  ///
  void onBtnEditClick() {
    Get.back();
  }

  ///
  ///on btn quotation click
  ///
  void onBtnQuotationClick() {
    Get.toNamed(
      AppRoutes.V2_QUOTATION_GROUP56,
      arguments: {
        'id': idDonDichVu.toString(),
        'donDichVu': donDichVuResponse,
      },
    );
  }

  ///
  /// Dinh dang ngay thang nam
  ///
  String getDateOutput(String dateString) {
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }

}
