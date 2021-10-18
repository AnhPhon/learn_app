import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V4ReportTimekeepingControllter extends GetxController {
  GetIt sl = GetIt.instance;
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();

  final reportTimekeeping = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));

  final reportContent = TextEditingController();
  String idChamCong = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidChamCong();
  }

  void getidChamCong() {
    sl.get<SharedPreferenceHelper>().chamcong.then((value) {
      idChamCong = value!;
      print(value);
    });
  }

  ///
  ///Check rỗng
  ///
  bool validate() {
    if (reportContent.text.toString().isEmpty) {
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
    return true;
  }

  ///
  /// Button báo cáo
  ///
  void report() {
    if (validate()) {
      final DateTime report = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(reportTimekeeping.text)
          .toString()
          .substring(0, 10));
      chamCongProvider.update(
        data: ChamCongRequest(
          id: idChamCong,
          thoiGianKetThuc: report.toString(),
          noiDungBaoCao: reportContent.text,
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
