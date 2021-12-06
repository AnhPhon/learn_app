import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/utils/app_constants.dart';

class V1ServiceReviewG6Controller extends GetxController {
  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  List<String> hinhAnhBanVe = [];

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;

  //loading
  bool isLoading = true;

  //thong so ky thuat
  List<bool> thongSoKyThuatListBool = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
      getThongSoKyThuat();
      thoiGianLamViec();
    }
  }

  ///
  ///get thong so ky thuat
  ///
  void getThongSoKyThuat() {
    thongSoKyThuatListBool = List<bool>.filled(donDichVuResponse.idThongSoKyThuats!.length, true);
    update();
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

      if (item.id == donDichVuResponse.idThoiGianLamViecs!.last.id) {
        isLoading = false;
        update();
      }
    }
  }
}
