import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/sharedpref/constants/enum_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1ServiceReviewG3Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;

  // 1 nam 2 nữ 3 khác
  GENDER gender = GENDER.Khac;

  //tinh trang
  String status = '';

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
    status = Get.parameters['trangThai'].toString();
    thoiGianLamViec();
    gioiTinh();
  }

  ///
  /// Chọn thời gian làm việc
  ///
  void thoiGianLamViec() {
    for (final item in donDichVuResponse.idThoiGianLamViecs!) {
      if (item.id == THOI_GIAN_LAM_VIEC.keys.toList()[0]) {
        tommorow = true;
      } else if (item.id == THOI_GIAN_LAM_VIEC.keys.toList()[1]) {
        afternoon = true;
      } else if (item.id == THOI_GIAN_LAM_VIEC.keys.toList()[2]) {
        tonight = true;
      }
    }
  }

  ///
  ///gioi tinh
  ///
  void gioiTinh() {
    if (donDichVuResponse.gioiTinh == '1') {
      gender = GENDER.Nam;
    } else if (donDichVuResponse.gioiTinh == '2') {
      gender = GENDER.Nu;
    }
    update();
  }
}
