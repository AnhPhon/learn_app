import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class V2ShorthandedGroup6Controller extends GetxController {
  String title = "Dịch vụ đang cần báo giá";

  String idDonDichVu = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

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
        if(Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() == DON_DICH_VU_DA_BAO_GIA){
          coTheBaoGia = false;
        }
        update();
      },
      onError: (error) {
        print('V2ShorthandedGroup6Controller getDetailDonDichVu onError $error');
      },
    );
  }

  /// Kiem tra da bao gia hay chua
  Future<void> kiemTraBaoGiaDonDichVu() async {
    final String? idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    danhSachBaoGiaDonDichVuProvider.paginate(
      limit: 1,
      page: 1,
      filter: '&idDonDichVu=$idDonDichVu&idTaiKhoanBaoGia=$idTaiKhoanBaoGia',
      onSuccess: (data) {
        if( data.isEmpty && (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == true || (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() != DON_DICH_VU_DA_BAO_GIA))){
          coTheBaoGia = true;
          update();
        } else {
          coTheBaoGia = false;
          update();
        }
      },
      onError: (error) {
        print('V2ShorthandedGroup6Controller kiemTraBaoGiaDonDichVu onError $error');
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
    if (dateString.isEmpty || dateString == 'null') return '';
    return DateConverter.isoStringToddMMYYYY(dateString.toString());
  }

}
