import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';

class V1ServiceReviewG3Controller extends GetxController {
  //DonDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //loai cong viec
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();
  LoaiCongViecResponse loaiCongViecResponse = LoaiCongViecResponse();

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
    getLoaiDichVu();
    thoiGianLamViec();
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
  ///loai dich vu
  ///
  void getLoaiDichVu() {
    loaiCongViecProvider.find(
      id: donDichVuResponse.idBangGiaDonHang!.idLoaiCongViec.toString(),
      onSuccess: (data) {
        loaiCongViecResponse = data;
        update();
      },
      onError: (error) {
        print("V1ServiceReviewG3Controller getLoaiDichVu onError $error");
      },
    );
  }
}
