import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/value_global_notifier.dart';

class V3ProjectController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;

  String title = "Dự án";

  List titleTabBar = [
    {
      'tieuDe': TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['tieuDe'],
      'id': TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['id'],
      'duAnKhachHangResponse': <DuAnKhachHangResponse>[].obs,
      'page': 1,
      'limit': 10,
    },
    {
      'tieuDe': TRANG_THAI_DU_AN['SAP_TRIEN_KHAI']['tieuDe'],
      'id': TRANG_THAI_DU_AN['SAP_TRIEN_KHAI']['id'],
      'duAnKhachHangResponse': <DuAnKhachHangResponse>[].obs,
      'page': 1,
      'limit': 10,
    },
  ];

  bool isLoading = true;
  bool initLoading = true;

  RxInt currentIndex = 0.obs;

  DuAnKhachHangProvider duAnKhachHangProvider = GetIt.I.get<DuAnKhachHangProvider>();

  final valueGlobalNotifier = sl.get<ValueGlobalNotifier>();

  String getDateOutput(int index) {
    if (currentIndex.value == 0) return DateConverter.isoStringToddMMYYYY(titleTabBar[0]['duAnKhachHangResponse'][index].ngayBatDau!.toString());
    return DateConverter.isoStringToddMMYYYY(titleTabBar[1]['duAnKhachHangResponse'][index].ngayKetThuc!.toString());
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: titleTabBar.length, vsync: this);

    // Init data du an khach hang
    getListDuAnKhachHang(0);
    getListDuAnKhachHang(1);
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex.value = index;
    tabController!.animateTo(index);
    update();
  }

  ///
  ///on project detail click
  ///
  void onProjectDetailClick(dynamic project) {
    final DuAnKhachHangResponse _project = project as DuAnKhachHangResponse;
    final String _titlePageDetail = _project.idTrangThaiDuAn!.id == TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['id'] ? 'Dự án đang triển khai' : 'Dự án sắp triển khai';
    Get.toNamed(AppRoutes.V3_PROJECT_DETAIL_TRIEN_KHAI, arguments: {'idProject': _project.id.toString(), 'title': _titlePageDetail});
  }

  ///
  /// get list du an khach hang
  ///
  Future<void> getListDuAnKhachHang(int indexOfTab) async {
    isLoading = true;

    final String _idTrangThaiDuAn = titleTabBar[indexOfTab]['id'].toString();
    if (_idTrangThaiDuAn == '') return;

    titleTabBar[indexOfTab]!['page'] = 1;
    titleTabBar[indexOfTab]!['limit'] = 5;

    await duAnKhachHangProvider.paginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&idTrangThaiDuAn=$_idTrangThaiDuAn&sortBy=created_at:desc",
      onSuccess: (data) {
        initLoading = false;
        if (data.isEmpty) {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV3Project_$indexOfTab', true);
        } else {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV3Project_$indexOfTab', false);
        }
        titleTabBar[indexOfTab]['duAnKhachHangResponse'].value = data;
        isLoading = false;

        update();
      },
      onError: (error) {
        print('V3ProjectController getListDuAnKhachHang onError $error');
      },
    );
  }

  ///
  /// get list load more du an khach hang
  ///
  Future<void> getListLoadMoreDuAnKhachHang(int indexOfTab) async {
    isLoading = true;

    final String _idTrangThaiDuAn = titleTabBar[indexOfTab]['id'].toString();
    if (_idTrangThaiDuAn == '') return;

    titleTabBar[indexOfTab]!['page'] += 1;

    await duAnKhachHangProvider.paginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&idTrangThaiDuAn=$_idTrangThaiDuAn&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV3Project_$indexOfTab', true);
        } else {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV3Project_$indexOfTab', false);
          titleTabBar[indexOfTab]['duAnKhachHangResponse'].value = titleTabBar[indexOfTab]['duAnKhachHangResponse'].value + data;
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print('V3ProjectController getListLoadMoreDuAnKhachHang $error');
      },
    );
  }

  ///
  ///reload
  ///
  Future<void> onRefresh() async {
    initLoading = true;
    update();
    await getListDuAnKhachHang(currentIndex.value);
  }

  ///
  ///load more
  ///
  Future<void> onLoading() async {
    await getListLoadMoreDuAnKhachHang(currentIndex.value);
  }
}
