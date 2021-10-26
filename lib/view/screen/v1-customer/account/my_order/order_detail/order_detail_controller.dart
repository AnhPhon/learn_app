import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/don_hang_provider.dart';

class V1OrderDetailController extends GetxController {
  //donHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangResponse donHangResponse = DonHangResponse();

  //chiTietDonHang
  ChiTietDonHangProvider chiTietDonHangProvider =
      GetIt.I.get<ChiTietDonHangProvider>();
  List<ChiTietDonHangResponse> chiTietDonHangList = [];

  //loading
  bool isLoading = true;

  //title appbar
  String title = "Chi tiết đơn hàng";

  @override
  void onInit() {
    super.onInit();
    donHangResponse = Get.arguments as DonHangResponse;
    getChiTietDonHang();
  }

  ///
  ///get chi tiet don hang
  ///
  void getChiTietDonHang() {
    chiTietDonHangProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idDonHang=${donHangResponse.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        chiTietDonHangList = data;
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1OrderDetailController getChiTietDonHang onError $error");
      },
    );
  }
}
