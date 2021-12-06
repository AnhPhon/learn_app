import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class V2ShorthandedGroup3Controller extends GetxController {
  String title = "Công việc đang cần người";

  String idDonDichVu = '';
  String idTaiKhoanBaoGia = '';

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse donDichVuResponse = DonDichVuResponse.fromJson({});

  DanhSachBaoGiaDonDichVuRequest danhSachBaoGiaDonDichVuRequest = DanhSachBaoGiaDonDichVuRequest.fromJson({});

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  bool coTheBaoGia = false;

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['id'] != null) {
      idDonDichVu = arguments!['id'] as String;
      title = arguments!['title'] as String;
      danhSachBaoGiaDonDichVuRequest.idDonDichVu = idDonDichVu;

      getDetailDonDichVu();
      kiemTraBaoGiaDonDichVu();
    }

    Future.delayed(Duration.zero, () async {
      idTaiKhoanBaoGia = (await sl.get<SharedPreferenceHelper>().userId)!;
    });
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
        print('V2ShorthandedGroup3Controller getDetailDonDichVu onError $error');
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
        if( data.isEmpty && (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == true || (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() != DON_DICH_VU_DA_BAO_GIA))){
          coTheBaoGia = true;
          update();
        } else {
          coTheBaoGia = false;
          update();
        }
      },
      onError: (error) {
        print('V2ShorthandedGroup3Controller kiemTraBaoGiaDonDichVu onError $error');
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
  Future<void> onAcceptClick() async {
    try {
      EasyLoading.show(status: 'Loading...');

      danhSachBaoGiaDonDichVuRequest.idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;

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
      print('V2QuotationG56Controller onDoneClick onError $e');
    }
  }

  ///
  ///accept
  ///
  Future<void> onAcceptThanhToanClick() async {
    try {
      final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({});

      donDichVuRequest.soTien = donDichVuResponse.soTien.toString();
      donDichVuRequest.phiDichVu = donDichVuResponse.phiDichVu.toString();
      donDichVuRequest.khuyenMai = donDichVuResponse.khuyenMai.toString();
      donDichVuRequest.tongDon = (int.parse(donDichVuRequest.soTien != 'null' ? donDichVuRequest.soTien! : '0') + int.parse(donDichVuRequest.phiDichVu != 'null' ? donDichVuRequest.phiDichVu! : '0') - int.parse(donDichVuRequest.khuyenMai != 'null' ? donDichVuRequest.khuyenMai! : '0')).toString();
      donDichVuRequest.updateTrangThaiThanhToanKhac = true;

      donDichVuRequest.idTaiKhoanNhanDon = idTaiKhoanBaoGia;
      donDichVuRequest.id = donDichVuResponse.id;
      Get.toNamed(
        AppRoutes.V2_WINNING_BID,
        arguments: {
          'id': idDonDichVu.toString(),
          'donDichVuResponse': donDichVuResponse,
        },
      )!
          .then((value) {
        if (value != null && value['reload'] == true) {
          getDetailDonDichVu();
        }
      });
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Kiem tra dieu kien hien thi nut thanh toan
  ///
  bool checkShowButtonThanhToan() {
    if (coTheBaoGia == true) return false;
    if (Validate.checkValueIsNullEmpty(donDichVuResponse.idTaiKhoanNhanDon) == true) return false;
    if (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == true) return false;
    if (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiThanhToan) == true) return false;
    if (donDichVuResponse.idTaiKhoanNhanDon!.id.toString() != idTaiKhoanBaoGia) return false;
    if (Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiThanhToanKhac) == false && (donDichVuResponse.idTrangThaiThanhToanKhac!.id.toString() == DA_THANH_TOAN || donDichVuResponse.idTrangThaiThanhToanKhac!.id.toString() == DAT_COT)) return false;
    if (donDichVuResponse.idTrangThaiDonDichVu!.id.toString() != DON_DICH_VU_DA_BAO_GIA && donDichVuResponse.idTrangThaiDonDichVu!.id.toString() != DON_DICH_VU_CHOT_GIA) return false;
    return true;
  }

  ///
  /// Kiem tra dieu kien hien thi nut nhan viec
  ///
  bool checkShowButtonNhanViec() {
    if (coTheBaoGia == true && Validate.checkValueIsNullEmpty(donDichVuResponse.idTrangThaiDonDichVu) == false && (donDichVuResponse.idTrangThaiDonDichVu!.id.toString() == DA_DUYET)) return true;
    return false;
  }
}
