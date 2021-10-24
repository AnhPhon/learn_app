import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1VatTuListController extends GetxController {
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  RefreshController? refreshDaPhanHoiController;
  RefreshController? refreshChuaPhanHoiController;
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

    refreshDaPhanHoiController ??= RefreshController();
    refreshChuaPhanHoiController ??= RefreshController();

    // loadDaPhanHoi
    loadDaPhanHoi();

    // loadChuaPhanHoi
    loadChuaPhanHoi();
  }

  @override
  void onClose() {
    refreshDaPhanHoiController!.dispose();
    refreshChuaPhanHoiController!.dispose();
    super.onClose();
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
    daPhanHoiDDV.clear();
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (phanHoiDonDichVuList) {
          // run don dich vu list
          for (final phanHoi in phanHoiDonDichVuList) {
            if (phanHoi.idDonDichVu != null) {
              // check trang thai
              donDichVuProvider.find(
                id: phanHoi.idDonDichVu!.id!,
                onSuccess: (data) {
                  if (data.idTrangThaiDonDichVu != null) {
                    if (data.idTrangThaiDonDichVu!.tieuDe
                            .toString()
                            .toLowerCase() ==
                        daPhanHoiKey) {
                      daPhanHoiDDV.add(data);
                    }
                  }
                  update();
                },
                onError: (error) {
                  print(
                      "TermsAndPolicyController getTermsAndPolicy onError $error");
                },
              );
            }
          }
          isLoading = false;
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
    chuaPhanHoiDDV.clear();
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (phanHoiDonDichVuList) {
          // run don dich vu list
          for (final phanHoi in phanHoiDonDichVuList) {
            donDichVuProvider.find(
              id: phanHoi.idDonDichVu!.id!,
              onSuccess: (data) {
                if (data.idTrangThaiDonDichVu != null) {
                  if (data.idTrangThaiDonDichVu!.tieuDe
                          .toString()
                          .toLowerCase() ==
                      chuaPhanHoiKey) {
                    chuaPhanHoiDDV.add(data);
                  }
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          }
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
  void onProductResponseClick(String id) {
    sl.get<SharedPreferenceHelper>().saveWorkFlow(id: id);
    Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE);
  }

  ///
  /// on da phan hoi refresh
  ///
  Future<void> onDaPhanHoiRefresh() async {
    loadDaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController!.refreshCompleted();
  }

  ///
  /// on da phan hoi loading
  ///
  Future<void> onDaPhanHoiLoading() async {
    loadDaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController!.loadComplete();
  }

  ///
  /// on chua phan hoi refresh
  ///
  Future<void> onChuaPhanHoiRefresh() async {
    loadChuaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController!.refreshCompleted();
  }

  ///
  /// on chua phan hoi loading
  ///
  Future<void> onChuaPhanHoiLoading() async {
    loadChuaPhanHoi();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController!.loadComplete();
  }
}
