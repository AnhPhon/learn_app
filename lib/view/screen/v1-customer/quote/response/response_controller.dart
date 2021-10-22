import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1ResponseController extends GetxController {
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  RefreshController refreshDaPhanHoiController = RefreshController();
  RefreshController refreshChuaPhanHoiController = RefreshController();

  Map<String, String> titleTabBar = {
    "DPH": "Đã phản hồi",
    "CPH": "Chưa phản hồi",
  };

  List<DonDichVuResponse> daPhanHoiDDV = [];
  List<DonDichVuResponse> chuaPhanHoiDDV = [];

  int currentIndex = 0;

  bool isLoading = true;

  String title = "Phản hồi đơn giá vật tư";

  String chuaPhanHoiKey = "chưa phản hồi";
  String daPhanHoiKey = "đã phản hồi";

  @override
  void onInit() {
    super.onInit();

    // loadDaPhanHoi
    loadDaPhanHoi();

    // loadChuaPhanHoi
    loadChuaPhanHoi();
  }

  @override
  void onClose() {
    super.onClose();
    refreshDaPhanHoiController.dispose();
    refreshChuaPhanHoiController.dispose();
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// load da phan hoi
  ///
  void loadDaPhanHoi() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      donDichVuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (donDichVuList) {
          // run don dich vu list
          for (final donDichVu in donDichVuList) {
            // check trang thai
            if (donDichVu.idTrangThaiDonDichVu!.tieuDe
                    .toString()
                    .toLowerCase() ==
                daPhanHoiKey) {
              daPhanHoiDDV.add(donDichVu);
            }
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load chua phan hoi
  ///
  void loadChuaPhanHoi() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      donDichVuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (donDichVuList) {
          // run don dich vu list
          for (final donDichVu in donDichVuList) {
            // check trang thai
            if (donDichVu.idTrangThaiDonDichVu!.tieuDe
                    .toString()
                    .toLowerCase() ==
                chuaPhanHoiKey) {
              chuaPhanHoiDDV.add(donDichVu);
            }
          }
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// go to Product Response
  ///
  void onProductResponseClick() {}

  ///
  /// on da phan hoi refresh
  ///
  Future<void> onDaPhanHoiRefresh() async {
    loadDaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController.refreshCompleted();
  }

  ///
  /// on da phan hoi loading
  ///
  Future<void> onDaPhanHoiLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController.loadComplete();
  }

  ///
  /// on chua phan hoi refresh
  ///
  Future<void> onChuaPhanHoiRefresh() async {
    loadChuaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController.refreshCompleted();
  }

  ///
  /// on chua phan hoi loading
  ///
  Future<void> onChuaPhanHoiLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController.loadComplete();
  }
}
