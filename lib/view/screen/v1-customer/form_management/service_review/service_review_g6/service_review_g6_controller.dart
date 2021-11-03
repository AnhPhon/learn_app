import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';
import 'package:template/provider/thong_so_ky_thuat_provider.dart';

class V1ServiceReviewG6Controller extends GetxController{
  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  List<String> hinhAnhBanVe = [];

  //thong so ky thuat
  ThongSoKyThuatProvider thongSoKyThuatProvider =
      GetIt.I.get<ThongSoKyThuatProvider>();
  List<ThongSoKyThuatResponse> thongSoKyThuatList = [];

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
    }
        // lấy hình ảnh bảng vẽ
    for (final banVe in donDichVuResponse.hinhAnhBanVes!) {
      if (banVe.trim().isNotEmpty) {
        hinhAnhBanVe.add(banVe);
      }
    }
    thoiGianLamViec();
    getThongSoKyThuat();
  }

  ///
  ///get thong so ky thuat
  ///
  void getThongSoKyThuat() {
    thongSoKyThuatProvider.all(
      onSuccess: (data) {
        thongSoKyThuatList = data;
        thongSoKyThuatListBool =
            List<bool>.generate(thongSoKyThuatList.length, (_) => false);
        for (var i = 0; i < donDichVuResponse.idThongSoKyThuats!.length; i++) {
          final index = thongSoKyThuatList.indexWhere((element) =>
              element.id == donDichVuResponse.idThongSoKyThuats![i].id);
          if (index != -1) {
            thongSoKyThuatListBool[index] = true;
          }
          if (i == donDichVuResponse.idThongSoKyThuats!.length - 1) {
            isLoading = false;
          }
        }
        update();
      },
      onError: (error) {
        print("V1ServiceReviewG5Controller getThongSoKyThuat onError $error");
      },
    );
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
}