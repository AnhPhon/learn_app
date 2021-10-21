import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V3QuoteListController extends GetxController {
  String title = "Danh sách báo giá đơn hàng";
  final DanhSachBaoGiaDonDichVuProvider _danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVuResponse = [];

  @override
  void onInit() {
    super.onInit();
    _loadDanhSachDonGiaDichVu();
  }

  ///
  /// go to reponse page
  ///
  void toReponse() {
    Get.toNamed(AppRoutes.V3_QUOTE_RESPONSE);
  }

  ///
  /// load danh sach don gia dich vu
  ///
  void _loadDanhSachDonGiaDichVu() {
    _danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 10,
      filter: "",
      onSuccess: (models) {
        danhSachBaoGiaDonDichVuResponse = models;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
