import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2HistoryRecruitmentNewsController extends GetxController {
  //Provider
  final danhSachLuuTinTuyenDungProvider =
      GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();

  final searchController = TextEditingController();

  //Reposion
  List<TuyenDungResponse> tuyenDungLuuTinTuyenDung = [];
  List<TuyenDungResponse> tuyenDungUngTuyenList = [];
  List<TuyenDungResponse> tuyenDungList = [];
  List<TuyenDungResponse> tuyenDungListSearch = [];

  //userId
  String? userId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      // getDataUngTuyen();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    super.onClose();
  }

  ///
  ///getDataUngTuyen
  ///
  // void getDataUngTuyen() {
  //   danhSachUngTuyenProvider.paginate(
  //       page: 1,
  //       limit: 20,
  //       filter: '&idTaiKhoanUngTuyen=$userId',
  //       onSuccess: (value) {
  //         print('úng tuyển ${value.length}');
  //         for (int i = 0; i < value.length; i++) {
  //           tuyenDungUngTuyenList
  //               // ignore: cast_nullable_to_non_nullable
  //               .add(value[i].idTuyenDung as TuyenDungResponse);
  //           tuyenDungUngTuyenList[i].isUngTuyen = true;
  //         }
  //         getDataLuuTinTuyenDung();
  //       },
  //       onError: (error) =>
  //           print('V2HistoryRecruitmentNewsController getDataUngTuyen $error'));
  // }

  ///
  ///getDataUngTuyen
  ///
  // void getDataLuuTinTuyenDung() {
  //   danhSachLuuTinTuyenDungProvider.paginate(
  //       page: 1,
  //       limit: 20,
  //       filter: '&idTaiKhoan=$userId',
  //       onSuccess: (value) {
  //         print(' lưu tuyển dụng ${value.length}');
  //         for (int i = 0; i < value.length; i++) {
  //           tuyenDungLuuTinTuyenDung
  //               // ignore: cast_nullable_to_non_nullable
  //               .add(value[i].idTuyenDung as TuyenDungResponse);
  //           tuyenDungLuuTinTuyenDung[i].isUngTuyen = false;
  //         }
  //       },
  //       onError: (error) =>
  //           print('V2HistoryRecruitmentNewsController getDataUngTuyen $error'));
  // }

  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews() {
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }
}
