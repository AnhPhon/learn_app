import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2HistoryRecruitmentNewsController extends GetxController {
  //Provider
  final danhSachLuuTinTuyenDungProvider =
      GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();

  final searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews() {
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }
}
