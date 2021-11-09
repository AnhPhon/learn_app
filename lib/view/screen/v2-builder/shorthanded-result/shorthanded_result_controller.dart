import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/du_an_khach_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/du_an_khach_hang_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V2ShorthandedResultController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;

  String title = "Kết quả báo giá";

  List titleTabBar = [
    {
      'tieuDe': 'Thành công',
      'type': '',
      'danhSachBaoGiaDonDichVuResponse': <DanhSachBaoGiaDonDichVuResponse>[].obs,
      'page': 1,
      'limit': 5,
    },
    {
      'tieuDe': 'Không thành công',
      'type': 'thatbai',
      'danhSachBaoGiaDonDichVuResponse': <DanhSachBaoGiaDonDichVuResponse>[].obs,
      'page': 1,
      'limit': 5,
    },
  ];

  bool isLoading = true;

  RxInt currentIndex = 0.obs;

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  String? idTaiKhoanBaoGia = '';

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: titleTabBar.length, vsync: this);

    ///
    /// Init data du an khach hang
    ///
    getListDonDichVu(0);
    getListDonDichVu(1);

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
  void onDetailClick(DanhSachBaoGiaDonDichVuResponse project) {
    if(currentIndex.value == 0){
      // Bao gia thanh cong
      print('project.idDonDichVu ${project.idDonDichVu}');
      print('project.idDonDichVu ${project.idDonDichVu!.idTrangThaiThanhToan!.toJson()}');
      print('project.idDonDichVu!.idTrangThaiThanhToan!.id.toString() ${project.idDonDichVu!.idTrangThaiThanhToan!.id.toString()}');
      if(project.idDonDichVu == null || project.idDonDichVu!.idTrangThaiThanhToan == null){
        Alert.error(message: 'Đơn dịch vụ không khả dụng');
      } else if(project.idDonDichVu!.idTrangThaiThanhToan!.id.toString() == DA_THANH_TOAN){
        Get.toNamed(AppRoutes.V2_SHORTHANDED_COMPLETE, arguments: {'idDonDichVu': project.idDonDichVu, 'title': ''});
      } else if(project.idDonDichVu!.idTrangThaiThanhToan!.id == CHUA_THANH_TOAN){
        Get.toNamed(AppRoutes.V2_SHORTHANDED_PAYMENT, arguments: {'idProject': project.id.toString(), 'title': ''});
      }

    } else {
      // Bao gia that bai

      Get.toNamed(AppRoutes.V2_FAIL,);
    }
    // final String _titlePageDetail = _project.idTrangThaiDuAn!.id == TRANG_THAI_DU_AN['DANG_TRIEN_KHAI']['id'] ? 'Dự án đang triển khai' : 'Dự án sắp triển khai';
    // Get.toNamed(AppRoutes.V2_PROJECT_DETAIL_TRIEN_KHAI, arguments: {'idProject': _project.id.toString(), 'title': _titlePageDetail});
  }

  ///
  /// get list du an khach hang
  ///
  Future<void> getListDonDichVu(int indexOfTab) async {
    print('getListDonDichVu $indexOfTab');
    idTaiKhoanBaoGia = await sl.get<SharedPreferenceHelper>().userId;
    isLoading = true;

    final String _typeDanhSachBaoGiaDonDichVu = titleTabBar[indexOfTab]['type'].toString();
    // if (_typeDanhSachBaoGiaDonDichVu == '') return;
    //
    titleTabBar[indexOfTab]!['page'] = 1;
    // titleTabBar[indexOfTab]!['limit'] = 5;

    print('"&type=$_typeDanhSachBaoGiaDonDichVu&&idTaiKhoanBaoGia=$idTaiKhoanBaoGia&sortBy=created_at:desc"');
    await danhSachBaoGiaDonDichVuProvider.ketQuaBaoGiaPaginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&type=$_typeDanhSachBaoGiaDonDichVu&&idTaiKhoanBaoGia=$idTaiKhoanBaoGia&sortBy=created_at:desc",
      onSuccess: (data) {
        print('paginate $data');
        titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value = data;
        isLoading = false;

        update();
      },
      onError: (error) {
        print('V1ProjectController getListDonDichVu onError $error');
      },
    );
  }

  ///
  /// get list load more du an khach hang
  ///
  Future<void> getListLoadMoreDuAnKhachHang(int indexOfTab) async {
    isLoading = true;

    final String _typeDanhSachBaoGiaDonDichVu = titleTabBar[indexOfTab]['type'].toString();
    // if (_typeDanhSachBaoGiaDonDichVu == '') return;

    titleTabBar[indexOfTab]!['page'] += 1;

    await danhSachBaoGiaDonDichVuProvider.ketQuaBaoGiaPaginate(
      page: titleTabBar[indexOfTab]!['page'] as int,
      limit: titleTabBar[indexOfTab]['limit'] as int,
      filter: "&type=$_typeDanhSachBaoGiaDonDichVu&&idTaiKhoanBaoGia=$idTaiKhoanBaoGia&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
        } else {
          titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value = titleTabBar[indexOfTab]['danhSachBaoGiaDonDichVuResponse'].value + data;
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print('V1NewsCategoriesController loadMoreNews $error');
      },
    );
  }

  ///
  ///reload
  ///
  Future<void> onRefresh() async {
    print('V1NewsCategoriesController onRefresh');
    await getListDonDichVu(currentIndex.value);
  }

  ///
  ///load more
  ///
  Future<void> onLoading() async {
    print('V1NewsCategoriesController onLoading');
    await getListLoadMoreDuAnKhachHang(currentIndex.value);
  }

  ///
  /// Format ngay thang nam
  ///
  String getDateOutput(int index) {
    if (currentIndex.value == 0) return DateConverter.isoStringToddMMYYYY(titleTabBar[0]['duAnKhachHangResponse'][index].ngayBatDau!.toString());
    return DateConverter.isoStringToddMMYYYY(titleTabBar[1]['duAnKhachHangResponse'][index].ngayKetThuc!.toString());
  }

}
