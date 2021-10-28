
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';


class V4DetailReportController  extends GetxController {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienProvider baoCaoNhanVienProvider = GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> baoCaoNhanVienList = [];

  DuAnNhanVienProvider duAnNhanVienProvider = GetIt.I.get<DuAnNhanVienProvider>();

  // Dự án của nhân viên
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;
  // khai báo is loading
  bool isLoading = true;

  String idUser= '';

  //khai báo TextEditingController
  final timeDetailReport = TextEditingController();
  final contentDetailReport = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidUser();
    // getDuAnNhanVien();
  }
  ///
  /// get id user
  ///
  void getidUser() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;
      print(value);
    });
  }
  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    this.duAnNhanVien = duAnNhanVien;
    update();
  }
  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDetailReport.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung báo cáo không hợp lệ!",
        "Vui lòng nhập nội dung báo cáo hợp lệ!",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(
          Icons.error_outline,
        ),
      );
      return false;
    }
    if (duAnNhanVien == null) {
      Get.snackbar(
        "Dự án không hơp lệ!", // title
        "Vui lòng chọn dự án hợp lệ!", // message
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return true;
  }
  ///
  ///Update button
  ///
  void onUpdate() {
    if (validate()) {
      baoCaoNhanVienProvider.update(
        data: BaoCaoNhanVienRequest(
          idNhanVien: idUser,
          idDuAnNhanVien: duAnNhanVien!.id,
          noiDung: contentDetailReport.text,
        ),
        onSuccess: (value) {
          Get.back(result: true);
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        },
      );
    }
  }
// @override
// void onInit() {
//   // TODO: implement onInit
//   super.onInit();
// }
}
