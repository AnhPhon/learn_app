import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';

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
}
