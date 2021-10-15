import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/provider/cham_cong_provider.dart';

class V4ReportTimekeepingControllter extends GetxController {
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();

  final reportTimekeeping = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));

  final reportContent = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //

  void report() {
    reportTimekeeping.text =
        DateConverter.readMongoToString(reportTimekeeping.text);
    chamCongProvider.add(
      data: ChamCongRequest(
        thoiGianKetThuc: reportTimekeeping.text,
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
