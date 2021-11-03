import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

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

        for (final model in models) {
          donDichVuProvider.find(
            id: model.idDonDichVu.toString(),
            onSuccess: (data) {
              donDichVus.add(data);
              isLoading = false;
              update();
            },
            onError: (error) {
              print(
                  "V3QuotePhanHoiBaoGiaController _loadDanhSachDonGiaDichVu onError $error");
            },
          );
        }
        // update();
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
