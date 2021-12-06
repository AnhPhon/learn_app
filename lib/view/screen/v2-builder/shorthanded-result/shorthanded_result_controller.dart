import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';
import 'package:template/utils/value_global_notifier.dart';

class V2ShorthandedResultController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;

  String title = "Kết quả báo giá";

  List titleTabBar = [
    {
      'tieuDe': 'Thành công',
      'type': '',
      'danhSachBaoGiaDonDichVuResponse': <DanhSachBaoGiaDonDichVuResponse>[].obs,
      'page': 1,
      'limit': 10,
    },
    {
      'tieuDe': 'Không thành công',
      'type': 'thatbai',
      'danhSachBaoGiaDonDichVuResponse': <DanhSachBaoGiaDonDichVuResponse>[].obs,
      'page': 1,
      'limit': 10,
    },
  ];

  bool isLoading = true;
  bool initLoading = true;

  RxInt currentIndex = 0.obs;

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  String? idTaiKhoanBaoGia = '';

  final valueGlobalNotifier = sl.get<ValueGlobalNotifier>();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: titleTabBar.length, vsync: this);
    // valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_0', false);
    // valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_1', false);

    // Init data du an khach hang
    getListDonDichVu(0);
    getListDonDichVu(1);
    // onChangeTab(0);
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
    // if(Validate.checkValueIsNullEmpty(titleTabBar[index]['danhSachBaoGiaDonDichVuResponse'].value) == true){
    //   valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$index', true);
    // } else {
    //   valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$index', false);
    // }
    update();
  }

  ///
  ///on project detail click
  ///
  void onDetailClick(DanhSachBaoGiaDonDichVuResponse project) {
    if (currentIndex.value == 0) {

      // Bao gia thanh cong
      if (project.idDonDichVu == null) {
        Alert.error(message: 'Đơn dịch vụ không khả dụng');
      } else if (project.idDonDichVu!.idTrangThaiThanhToanKhac != null && (project.idDonDichVu!.idTrangThaiThanhToanKhac!.id.toString() == DA_THANH_TOAN || project.idDonDichVu!.idTrangThaiThanhToanKhac!.id.toString() == DAT_COT)) {
        Get.toNamed(AppRoutes.V2_SHORTHANDED_COMPLETE, arguments: {'idDonDichVu': project.idDonDichVu, 'title': 'Kết quả báo giá'});
      } else if (project.idDonDichVu!.idTrangThaiThanhToanKhac == null || project.idDonDichVu!.idTrangThaiThanhToanKhac!.id == CHUA_THANH_TOAN || project.idDonDichVu!.idTrangThaiThanhToanKhac!.id.toString() == DAT_COT) {
        if (Validate.checkValueIsNullEmpty(project.idDonDichVu) == false && Validate.checkValueIsNullEmpty(project.idDonDichVu!.idNhomDichVu) == false) {
          if (project.idDonDichVu!.idNhomDichVu!.id.toString() == NHOM_DICH_VU_3) {
            // Nhóm 3
            Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP3, arguments: {'id': project.idDonDichVu!.id.toString(), 'title': 'Kết quả báo giá'});
          } else if (project.idDonDichVu!.idNhomDichVu!.id.toString() == NHOM_DICH_VU_4) {
            // Nhóm 4
            Get.toNamed(AppRoutes.V2_SHORTHANDED_GROUP4, arguments: {'id': project.idDonDichVu!.id.toString(), 'title': 'Kết quả báo giá'});
          } else {
            Get.toNamed(AppRoutes.V2_SHORTHANDED_PAYMENT, arguments: {'danhSachBaoGiaDonDichVu': project, 'title': 'Thanh toán báo giá'})!.then((value) {
              if (value != null && value['reload'] == true) {
                onRefresh();
                getListDonDichVu(0);
                getListDonDichVu(1);
              }
            });
          }
        } else {
          Get.toNamed(AppRoutes.V2_SHORTHANDED_PAYMENT, arguments: {'danhSachBaoGiaDonDichVu': project, 'title': ''})!.then((value) {
            if (value != null && value['reload'] == true) {
              onRefresh();
              getListDonDichVu(0);
              getListDonDichVu(1);
            }
          });
        }
      }
    } else {
      // Bao gia that bai
      if (project.idDonDichVu!.idTrangThaiDonDichVu != null && (project.idDonDichVu!.idTrangThaiDonDichVu!.id.toString() == DA_HUY)) {
        Get.toNamed(AppRoutes.V2_SHORTHANDED_PAYMENT, arguments: {'danhSachBaoGiaDonDichVu': project, 'title': 'Kết quả báo giá', 'showButton': false})!.then((value) {
          if (value != null && value['reload'] == true) {
            onRefresh();
            getListDonDichVu(0);
            getListDonDichVu(1);
          }
        });
      } else {
        Get.toNamed(
          AppRoutes.V2_FAIL,
        );
      }
    }
  }

  ///
  /// get list du an khach hang
  ///
  Future<void> getListDonDichVu(int indexOfTab) async {
    idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    isLoading = true;

    final String _typeDanhSachBaoGiaDonDichVu = titleTabBar[indexOfTab]['type'].toString();
    titleTabBar[indexOfTab]!['page'] = 1;

    await danhSachBaoGiaDonDichVuProvider.ketQuaBaoGiaPaginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&type=$_typeDanhSachBaoGiaDonDichVu&&idTaiKhoanBaoGia=$idTaiKhoanBaoGia&sortBy=created_at:desc",
      onSuccess: (data) {
        if(initLoading) initLoading = false;
        print('GetXSmartRefreshPageV2ShorthandedResult_$indexOfTab xxx ${data.isEmpty}');
        if (data.isEmpty) {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$indexOfTab', true);
        } else {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$indexOfTab', false);
        }
        titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value = data;
        isLoading = false;

        update();
      },
      onError: (error) {
        isLoading = false;
        print('V2ShorthandedResultController getListDonDichVu onError $error');
      },
    );
  }

  ///
  /// get list load more du an khach hang
  ///
  Future<void> getListLoadMoreDuAnKhachHang(int indexOfTab) async {
    isLoading = true;

    final String _typeDanhSachBaoGiaDonDichVu = titleTabBar[indexOfTab]['type'].toString();

    titleTabBar[indexOfTab]!['page'] += 1;

    await danhSachBaoGiaDonDichVuProvider.ketQuaBaoGiaPaginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&type=$_typeDanhSachBaoGiaDonDichVu&&idTaiKhoanBaoGia=$idTaiKhoanBaoGia&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$indexOfTab', true);
        } else {
          titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value = titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value + data;
          valueGlobalNotifier.changeSmartRefreshNoDataStatus('GetXSmartRefreshPageV2ShorthandedResult_$indexOfTab', false);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        print('V2ShorthandedResultController getListLoadMoreDuAnKhachHang $error');
      },
    );
  }

  ///
  ///reload
  ///
  Future<void> onRefresh() async {
    initLoading = true;
    update();
    await getListDonDichVu(currentIndex.value);
  }

  ///
  ///load more
  ///
  Future<void> onLoading() async {
    await getListLoadMoreDuAnKhachHang(currentIndex.value);
  }

  ///
  /// Format ngay thang nam
  ///
  String getDateOutput(int index) {
    if (currentIndex.value == 0) return DateConverter.isoStringToddMMYYYY(titleTabBar[0]['duAnKhachHangResponse'][index].ngayBatDau!.toString());
    return DateConverter.isoStringToddMMYYYY(titleTabBar[1]['duAnKhachHangResponse'][index].ngayKetThuc!.toString());
  }

  ///
  /// Get text trang thai thanh toan
  ///
  String getTextTrangThaiThanhToan(DanhSachBaoGiaDonDichVuResponse danhSachBaoGiaDonDichVu) {
    if (currentIndex.value == 0) {
      if (Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiThanhToanKhac) == false) {
        return Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiThanhToanKhac!.tieuDe.toString()) == false ? danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiThanhToanKhac!.tieuDe.toString() : 'Chưa thanh toán';
      }
      return 'Chưa thanh toán';
    } else if (currentIndex.value == 1) {
      if (Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiDonDichVu) == false) {
        if(danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiDonDichVu!.id == DON_DICH_VU_TRUNG_THAU) {
          return 'Không trúng thầu';
        } else {
          return Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiDonDichVu!.tieuDe.toString()) == false ? danhSachBaoGiaDonDichVu.idDonDichVu!.idTrangThaiDonDichVu!.tieuDe.toString() : 'Thất bại';
        }
      }
      return 'Thất bại';
    }

    return '';
  }
}
