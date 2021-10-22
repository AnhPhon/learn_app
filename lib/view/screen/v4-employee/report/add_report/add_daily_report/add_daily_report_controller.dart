import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V4AddDailyReportController extends GetxController {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienProvider baoCaoNhanVienProviderProvider = GetIt.I.get<BaoCaoNhanVienProvider>();

  final timeDailyReport = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));
  final projectDailyReport = TextEditingController();
  final contentDailyReport = TextEditingController();

  ///
  ///Check rỗng
  ///
  bool validate() {
    if (contentDailyReport.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung không hợp lệ!",
        "Vui lòng nội dung hợp lệ!",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(
          Icons.error_outline,
        ),
      );
      return false;
    }
    if (projectDailyReport.text.toString().isEmpty) {
      Get.snackbar(
        "Dự án không hơp lệ!",
        "Vui lòng nhập dự án hợp lệ!",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(
          Icons.error_outline,
        ),
      );
      return false;
    }
    return true;
  }
  ///
  /// Button báo cáo
  ///
  void dailyReport() {
    if (validate()) {
      final DateTime report = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeDailyReport.text)
          .toString()
          .substring(0, 10));
      baoCaoNhanVienProviderProvider.add(
        data: BaoCaoNhanVienRequest(
          // : projectDailyReport.text,
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
}
