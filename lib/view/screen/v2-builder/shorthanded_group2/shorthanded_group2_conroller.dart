import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class V2ShorthandedGroup2Controller extends GetxController {
  String title = "Công việc đang cần người";
  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  List<VatTuResponse>? vatTuResponse;

  ChiTietVatTuProvider chiTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();
  List<ChiTietVatTuResponse>? chiTietVatTuResponse;

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  bool flagSeeMore = false;
  bool coTheBaoGia = false;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      title = arguments!['title'] as String;
      getDetailDonDichVu();
      kiemTraBaoGiaDonDichVu();
    }

    Future.delayed(Duration.zero, () {});
  }

  ///
  /// Lay chi tiet don dich vu
  ///
  void getDetailDonDichVu() {
    donDichVuProvider.find(
      id: idDonDichVu.toString(),
      onSuccess: (data) {
        donDichVuResponse = data;
        if (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() == DON_DICH_VU_DA_BAO_GIA) {
          coTheBaoGia = false;
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedGroup2Controller getDetailDonDichVu onError $error');
      },
    );
  }

  ///
  /// Kiem tra da bao gia hay chua
  ///
  Future<void> kiemTraBaoGiaDonDichVu() async {
    final String? idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachBaoGiaDonDichVuProvider.paginate(
      limit: 1,
      page: 1,
      filter: '&idDonDichVu=$idDonDichVu&idTaiKhoanBaoGia=$idTaiKhoanBaoGia',
      onSuccess: (data) {
        if (data.isEmpty && (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == true || (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() != DON_DICH_VU_DA_BAO_GIA))) {
          coTheBaoGia = true;
          update();
        } else {
          coTheBaoGia = false;
          update();
        }
      },
      onError: (error) {
        print('V2ShorthandedGroup2Controller kiemTraBaoGiaDonDichVu onError $error');
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
    )!
        .then((value) {
      kiemTraBaoGiaDonDichVu();
    });
  }

  ///
  /// Dinh dang ngay thang nam
  ///
  String getDateOutput(String dateString) {
    if (dateString.isEmpty || dateString == 'null') return '';
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }
}
