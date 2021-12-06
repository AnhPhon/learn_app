import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class V1ServiceReviewG2Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  // Chọn thời gian làm việc
  bool tommorow = false;
  bool afternoon = false;
  bool tonight = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
    }
    thoiGianLamViec();
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
  ///download file
  ///
  Future<void> downloadFile({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'V1JobDetailController downloadFile Could not launch $url';
    }
  }
}
