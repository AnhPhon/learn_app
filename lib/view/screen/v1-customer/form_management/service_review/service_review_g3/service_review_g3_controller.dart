import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/sharedpref/constants/enum_helper.dart';

class V1ServiceReviewG3Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;

  // 1 nam 2 nữ 3 khác
  GENDER gender = GENDER.Khac;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
    thoiGianLamViec();
    gioiTinh();
  }

  ///
  /// Chọn thời gian làm việc
  ///
  void thoiGianLamViec() {
    for (final item in donDichVuResponse.idThoiGianLamViecs!) {
      if (item.tieuDe!.contains('7h30 - 11h30')) {
        tommorow = true;
      } else if (item.tieuDe!.contains('13h30 - 17h30')) {
        afternoon = true;
      } else if (item.tieuDe!.contains('18h30 - 22h30')) {
        tonight = true;
      }
    }
  }

  ///
  ///gioi tinh
  ///
  void gioiTinh() {
    if (donDichVuResponse.gioiTinh!
        .toLowerCase()
        .contains('Nam'.toLowerCase())) {
      gender = GENDER.Nam;
    } else if (donDichVuResponse.gioiTinh!
        .toLowerCase()
        .contains('Nữ'.toLowerCase())) {
      gender = GENDER.Nu;
    }
    update();
  }
}
