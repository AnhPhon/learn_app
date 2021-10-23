import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:url_launcher/url_launcher.dart';

class V4SalaryController extends GetxController {
//Khai bao isLoading
  bool isLoading = true;

  final salaryController = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  ///
  ///Get thông tin bảng lương viên
  ///

  ///
  ///btn xem luong
  ///
  Future<void> bntXemLuong({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "TermsAndPolicyController getTermsAndPolicy onError  $url";
    }
  }
}
