import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup2Controller extends GetxController {
  String title = "Công việc đang cần người";
  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVuResponse;

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse>? vatTuResponse;

  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  List<ChiTietVatTuResponse>? chiTietVatTuResponse;

  bool flagSeeMore = false;

  String getDateOutput(String dateString) {
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }

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
        // getListChiTietVatTu();
      },
      onError: (error) {
        print(
            'V2ShorthandedGroup1Controller getDetailDonDichVu onError $error');
      },
    );
  }

  ///
  ///go to quotation g2 page
  ///
  void onQuotationG2PageClick() {
    Get.toNamed(
      AppRoutes.V2_QUOTATION_GROUP2,
      arguments: {
        'id': idDonDichVu.toString(),
      },
    );
  }
}
