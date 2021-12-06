import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/utils/alert.dart';
import 'package:url_launcher/url_launcher.dart';

class V2ShorthandedCompleteController extends GetxController
    with SingleGetTickerProviderMixin {
  String title = "Thông tin khách hàng";

  bool isLoading = true;

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonDichVuResponse idDonDichVu = DonDichVuResponse.fromJson({});

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idDonDichVu'] != null) {
      idDonDichVu = arguments!['idDonDichVu'] as DonDichVuResponse;
    }
  }

  Future<void> callToNumber() async {
    if (idDonDichVu.idTaiKhoan == null ||
        idDonDichVu.idTaiKhoan!.soDienThoai == null ||
        idDonDichVu.idTaiKhoan!.soDienThoai!.isEmpty ||
        idDonDichVu.idTaiKhoan!.soDienThoai == 'null') {
      Alert.error(message: 'Số điện thoại không khả dụng');
    } else {
      final String url =
          "tel:${idDonDichVu.idTaiKhoan!.soDienThoai.toString()}";
      if (await canLaunch(url) == true) {
        await launch(url);
      } else {
        Alert.error(message: 'Số điện thoại không khả dụng');
      }
    }
  }
}
