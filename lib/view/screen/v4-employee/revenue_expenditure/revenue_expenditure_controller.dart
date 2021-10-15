import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thu_chi_nhan_vien_response.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';

class V4RevenueExpenditureController extends GetxController {
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  List<ThuChiNhanVienResponse> thuChiNhanVienModelList = [];
  //khai báo isLoading
  bool isLoading = true;

  bool isRevenue = true;

  final timeRevenueExpenditure = TextEditingController();
  final revenueController = TextEditingController(text: "Thu");
  final expenditureController = TextEditingController(text: "Chi");
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

  void onAddThu() {
    revenueController.text = '1';
    print(revenueController.text);
  }
}
