import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/routes/app_routes.dart';

class V3QuotePhanHoiBaoGiaController extends GetxController {
  String title = "Danh sách phản hồi đơn giá";

  final DanhSachBaoGiaDonDichVuProvider _danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  final QuanHuyenProvider _quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final DonDichVuProvider _donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  List<DanhSachBaoGiaDonDichVuResponse> danhSachBaoGiaDonDichVuResponse = [];

  Map<String, String> titleTabBar = {
    "DPH": "Đã phản hồi",
    "CPH": "Chưa phản hồi",
  };

  List<DonDichVuResponse> donDichVuList = [];
  List<String> quanHuyenNameList = [];
  int currentIndex = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // load danh sach don gia dich vu
    _loadDanhSachDonGiaDichVu();
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// go to Product Response
  ///
  void onProductResponseClick() {}

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
      limit: 10,
      page: 1,
      filter: "",
      onSuccess: (models) {
        danhSachBaoGiaDonDichVuResponse = models;

        models.forEach((model) {
          _loadDonDichVu(model.idDonDichVu!.id!);
        });

        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  void _loadDonDichVu(String id) {
    _donDichVuProvider.find(
      id: id,
      onSuccess: (model) {
        print(model);
        // _quanHuyen(model.idQuanHuyen)
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// lấy tên quận huyện
  ///
  void _quanHuyen(String id) {
    _quanHuyenProvider.find(
      id: id,
      onSuccess: (value) {
        quanHuyenNameList.add(value.ten!);
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
