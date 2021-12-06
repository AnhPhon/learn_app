import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V3QuoteListController extends GetxController {
  // provider
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  // list
  List<DonDichVuResponse> donDichVus = [];

  List<String> nhomValidList = ["8"];
  String daDuyetValid = "đã duyệt";

  bool isLoading = true;

  String title = "Yêu cầu báo giá";
  RefreshController donDichVuOnRefresh = RefreshController();
  bool isSearched = false;

  int page = 1;

  @override
  void onInit() {
    super.onInit();

    // load danh sách đơn giá dịch vu
    loadDanhSachDonGiaDichVu(page);
    update();
  }

  ///
  /// go to reponse page
  ///
  void onYeuCauBaoGiaPageClick(DonDichVuResponse idDonDichVu) {
    Get.toNamed(AppRoutes.V3_QUOTE_REQUEST, arguments: idDonDichVu)!
        .then((value) {
      onDonDichVuRefresh();
    });
  }

  ///
  /// load danh sach don gia dich vu
  ///
  void loadDanhSachDonGiaDichVu(int page) {
    // clear data
    donDichVus.clear();

    sl.get<SharedPreferenceHelper>().userId.then((value) {
      // get danh sách đơn dịch vụ provider
      donDichVuProvider.paginate(
        filter:
            "&idTrangThaiDonDichVu=$DA_DUYET&idNhomDichVu=$NHOM_DICH_VU_8&sortBy=created_at:desc",
        page: page,
        limit: 7,
        onSuccess: (models) {
          if (models.isEmpty) {
            donDichVuOnRefresh.loadNoData();
          }
          // load đơn dịch vụ theo nhom 8 và đã duyệt
          for (final ddv in models) {
            danhSachBaoGiaDonDichVuProvider.paginate(
              page: 1,
              limit: 5,
              filter: "&idDonDichVu=${ddv.id}&idTaiKhoanBaoGia=$value",
              onSuccess: (data) {
                if (data.isEmpty) {
                  donDichVus.add(ddv);
                }
                update();
              },
              onError: (error) {
                print(error);
              },
            );
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

  ///
  /// on don dich vu refresh
  ///
  Future<void> onDonDichVuRefresh() async {
    page = 1;
    donDichVus.clear();
    loadDanhSachDonGiaDichVu(page);
    donDichVuOnRefresh.resetNoData();
    donDichVuOnRefresh.refreshCompleted();
  }

  ///
  /// on don dich vu loading
  ///
  Future<void> onDonDichVuLoading() async {
    page++;
    loadDanhSachDonGiaDichVu(page);
    donDichVuOnRefresh.loadComplete();
  }
}
