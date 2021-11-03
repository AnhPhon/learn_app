import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3QuoteListController extends GetxController {
  final DanhSachBaoGiaDonDichVuProvider _danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVuResponse = [];
  List<DonDichVuResponse> donDichVus = [];

  bool isLoading = true;

  String title = "Danh sách báo giá đơn hàng";
  @override
  void onInit() {
    super.onInit();
    _loadDanhSachDonGiaDichVu();
  }

  ///
  /// go to reponse page
  ///
  void onYeuCauBaoGiaPageClick(String idDonDichVu) {
    sl.get<SharedPreferenceHelper>().saveIdDonDichVu(id: idDonDichVu);
    Get.toNamed(AppRoutes.V3_QUOTE_REQUEST);
  }

  ///
  /// load danh sach don gia dich vu
  ///
  void _loadDanhSachDonGiaDichVu() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      _danhSachBaoGiaDonDichVuProvider.paginate(
        page: 1,
        limit: 10,
        // filter: "&idTaiKhoanBaoGia=$userId",
        filter: "",
        onSuccess: (models) {
          danhSachBaoGiaDonDichVuResponse = models;

          for (final model in models) {
            donDichVus.add(model.idDonDichVu!);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        },
      );
    });
  }
}
