import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V4RevenueExpenditureController extends GetxController {
  //khai báo isLoading
  bool isLoading = true;

  bool isRevenue = true;

  final timeRevenueExpenditure = TextEditingController();
  final revenueController = TextEditingController();
  final expenditureController = TextEditingController();
  final contentRevenueController = TextEditingController();
  final contentExpenditureController = TextEditingController();
  final moneyController = TextEditingController();
  final detailContentRevenueController = TextEditingController();
  final detailContentExpenditureController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isRevenue = Get.parameters["revenue"].toString() == 'true';
  }
}
