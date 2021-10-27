import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:isoweek/isoweek.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V4AddDailyReportController extends GetxController {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienProvider baoCaoNhanVienProvider = GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> baoCaoNhanVienList = [];

  DuAnNhanVienProvider duAnNhanVienProvider = GetIt.I.get<DuAnNhanVienProvider>();
  // Dự án của nhân viên
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  final timeDailyReport = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));
  final projectDailyReport = TextEditingController();
  final contentDailyReport = TextEditingController();
  //khai báo biến isLoading
  bool isLoading = true;

  String idUser= '';

  //Khai báo Ngày đầu tiên của năm

  //Lấy được số ngày trong năm
  // final date = DateTime.now();
  // final diff = now.difference(new DateTime(date.year, 1, 1, 0, 0));
  // final diffInDays = diff.inDays;
  //
  // int weekNumber(DateTime date) {
  //   int dayOfYear = int.parse(DateFormat("D").format(date));
  //   return ((dayOfYear - date.weekday + 10) / 7).floor();
  // }

  int currentWeek = Week.current().weekNumber;
  // late Week one;
  //OUTPUT: 2021W13
  //Lấy số tuần bằng cách chia lấy phần nguyên số ngày trong năm cho 7
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidUser();
    getDuAnNhanVien();
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
  ///Lấy dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienList.clear();
        if (value.isNotEmpty) {
          duAnNhanVienList.addAll(value);
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
        update();
      },
    );
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDailyReport.text.toString().isEmpty) {
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

  // void chuyenDoiTuanHienTaiSangNguyen(){
  //   String? currentW = Week.current();
  //   return String cur = currentW.replaceALl("${year}W${weekNumber.toString().padLeft(2, '0')", "${weekNumber.toString().padLeft(2, '0')");
  // }
  ///
  /// Button báo cáo
  ///
  void dailyReport() {
    if (validate()) {
      baoCaoNhanVienProvider.add(
        data: BaoCaoNhanVienRequest(
          idNhanVien: idUser,
          idDuAnNhanVien: duAnNhanVien!.id,
          loai: "2",
          soTuan: currentWeek.toString(),

          noiDung: contentDailyReport.text,
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
  // ///
  // ///format week
  // ///
  // String formatWeek({required String dateTime}) {
  //   return currentWeek(
  //       dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
  //       .toString();
  // }
}
