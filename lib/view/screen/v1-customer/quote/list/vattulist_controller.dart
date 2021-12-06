import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class V1VatTuListController extends GetxController
    with SingleGetTickerProviderMixin {
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  RefreshController? refreshDaPhanHoiController;
  RefreshController? refreshChuaPhanHoiController;
  List<DonDichVuResponse> daPhanHoiDDV = [];
  List<DonDichVuResponse> chuaPhanHoiDDV = [];

  TabController? tabController;

  int currentIndex = 0;

  bool isLoading = true;
  int page1 = 1;
  int page2 = 1;

  String title = "Quản lý báo giá";

  List<String> titleTabBar = ["Đã phản hồi", "Chưa phản hồi"];
  List<String> chuaPhanHoiKey = [CHUA_PHAN_HOI, DA_DUYET];
  List<String> daPhanHoiKey = [DA_BAO_GIA, CHOT_GIA, TRUNG_THAU, THAT_BAI];
  List<String> nhomValidList = ["nhóm 8"];

  List<List<DonDichVuResponse>>? donDichVuLists;

  List<Function()>? onRefreshList;

  List<Function()>? onLoadingList;

  // String daPhanHoiKey = "đã phản hồi";

  @override
  void onInit() {
    super.onInit();

    refreshDaPhanHoiController ??= RefreshController();
    refreshChuaPhanHoiController ??= RefreshController();

    tabController = TabController(length: 2, vsync: this);

    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      // load da phan hoi
      loadData(userId.toString(), 1);

      // load chua phan hoi
      loadData(userId.toString(), 2);
    });
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

    refreshDaPhanHoiController!.resetNoData();
    refreshChuaPhanHoiController!.resetNoData();

    update();
  }

  ///
  /// load da phan hoi
  ///
  void loadData(String id, int index) {
    daPhanHoiDDV.clear();
    chuaPhanHoiDDV.clear();

    // load da phan hoi
    if (index == 1) {
      page1 = 1;
      loadDaPhanHoi(id.toString(), page1);
    }

    // load chua phan hoi
    if (index == 2) {
      page2 = 1;
      loadChuaPhanHoi(id.toString(), page2);
    }
  }

  ///
  /// load dữ liệu đã phản hồi
  ///
  void loadDaPhanHoi(String idTaiKhoan, int page) {
    donDichVuProvider.paginate(
      page: page,
      limit: 20,
      filter: '&idNhomDichVu=$NHOM_DICH_VU_8&sortBy=created_at:desc',
      onSuccess: (donDichVuList) {
        if (donDichVuList.isEmpty) {
          refreshDaPhanHoiController!.loadNoData();
        }

        for (final item in donDichVuList) {
          if (daPhanHoiKey.contains(item.idTrangThaiDonDichVu!.id.toString()) &&
              item.idTaiKhoanNhanDon!.id == idTaiKhoan) {
            daPhanHoiDDV.add(item);
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
      },
    );
  }

  ///
  /// load dữ liệu chưa phản hồi
  ///
  void loadChuaPhanHoi(String idTaiKhoan, int page) {
    donDichVuProvider.paginate(
      page: page,
      limit: 20,
      filter: '&idNhomDichVu=$NHOM_DICH_VU_8&sortBy=created_at:desc',
      onSuccess: (donDichVuList) {
        if (donDichVuList.isEmpty) {
          refreshChuaPhanHoiController!.loadNoData();
        }

        for (final item in donDichVuList) {
          danhSachBaoGiaDonDichVuProvider.paginate(
            page: 1,
            limit: 20,
            filter: "&idDonDichVu=${item.id}&idTaiKhoanBaoGia=$idTaiKhoan",
            onSuccess: (data) {
              if (data.isNotEmpty &&
                  chuaPhanHoiKey
                      .contains(item.idTrangThaiDonDichVu!.id.toString())) {
                chuaPhanHoiDDV.add(item);
              }
            },
            onError: (error) {
              print(
                  "V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
            },
          );
        }
        update();
      },
      onError: (error) {
        print("V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
      },
    );
  }

  ///
  /// go to Product Response
  ///
  void onProductResponseClick(DonDichVuResponse id) {
    Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE, arguments: id)!.then((value) {
      if (value != null) {
        onDaDonPhanHoiRefresh();
        onChuaDonPhanHoiRefresh();
      }
    });
  }

  ///
  /// go to Product Response
  ///
  void onProductNoResponseClick(DonDichVuResponse id) {
    Get.toNamed(AppRoutes.V1_QUOTE_NO_RESPONSE, arguments: id);
  }

  ///
  /// on đơn phan hoi refresh
  ///
  Future<void> onDaDonPhanHoiRefresh() async {
    page1 = 1;
    daPhanHoiDDV.clear();
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      loadDaPhanHoi(id.toString(), page1);
    });
    refreshDaPhanHoiController!.refreshCompleted();
    refreshDaPhanHoiController!.resetNoData();
  }

  ///
  /// on đơn phan hoi loading
  ///
  Future<void> onDaDonPhanHoiLoading() async {
    page1++;
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      loadDaPhanHoi(id.toString(), page1);
    });
    refreshDaPhanHoiController!.loadComplete();
  }

  ///
  /// on đơn phan hoi refresh
  ///
  Future<void> onChuaDonPhanHoiRefresh() async {
    page2 = 1;
    chuaPhanHoiDDV.clear();
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      loadChuaPhanHoi(id.toString(), page2);
    });
    refreshChuaPhanHoiController!.refreshCompleted();
    refreshChuaPhanHoiController!.resetNoData();
  }

  ///
  /// on đơn phan hoi loading
  ///
  Future<void> onChuaDonPhanHoiLoading() async {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      page2++;
      loadChuaPhanHoi(id.toString(), page2);
    });
    refreshChuaPhanHoiController!.loadComplete();
  }
}
