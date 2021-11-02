import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup1Controller extends GetxController {
  String title = "Công việc đang cần người";
  //
  // String urlImage = "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";
  //
  // List imageListWeight = [
  //   "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
  // ];

  // List imageListDraw = [];

  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVuResponse;

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse>? vatTuResponse;

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
        print('V2ShorthandedGroup1Controller getDetailDonDichVu onSuccess ${donDichVuResponse!.toJson()}');
        print('V2ShorthandedGroup1Controller getDetailDonDichVu onSuccess ${donDichVuResponse!.idBangGiaDonHang!.toJson()}');
        update();
        getVatTu();
      },
      onError: (error) {
        print('V2ShorthandedGroup1Controller getDetailDonDichVu onError $error');
      },
    );
  }

  /// Lay danh sach vat tu cua don dich vu
  void getVatTu() {
    vatTuProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idDonDichVu=${idDonDichVu.toString()}',
      onSuccess: (data) {
        vatTuResponse = data;
        print('V2ShorthandedGroup1Controller getVatTu onSuccess ${vatTuResponse}');
        update();
      },
      onError: (error) {
        print('V2ShorthandedGroup1Controller getVatTu onError $error');
      },
    );
  }

  ///
  ///go to quotation g1 page
  ///
  void onQuotationG1PageClick() {
    Get.toNamed(
      AppRoutes.V2_QUOTATION_GROUP1,
      arguments: {'id': idDonDichVu.toString(),},
    );
  }

  void showMoreVatTu() {
    flagSeeMore = true;
    update();
  }
}
