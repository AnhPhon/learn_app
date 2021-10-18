import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/thu_chi_nhan_vien_request.dart';
import 'package:template/data/model/response/thu_chi_nhan_vien_response.dart';

import 'package:template/provider/thu_chi_nhan_vien_provider.dart';

class V4RevenueExpenditureController extends GetxController {
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  List<ThuChiNhanVienResponse> thuChiNhanVienModelList = [];
  //khai báo isLoading
  bool isLoading = true;

  bool isRevenue = true;

  //Set ngày hiện Tại
  String timeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

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

  ///
  /// Check null value THÊM THU
  ///
  bool validateThu() {
    if (timeRevenueExpenditure.text.toString().isEmpty) {
      Get.snackbar("Ngày không hợp lệ!", "Vui lòng chọn ngày hợp lệ!");
      return false;
    }
    if (contentRevenueController.text.toString().isEmpty) {
      Get.snackbar("Nội dung thu chính không hơp lệ!",
          "Vui lòng nhập nội dung thi chính hợp lệ!");
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Get.snackbar("Số tiền không hơp lệ!", "Vui lòng nhập số tiền hợp lệ!");
      return false;
    }
    if (detailContentRevenueController.text.toString().isEmpty) {
      Get.snackbar("Nội dung chi tiết không hơp lệ!",
          "Vui lòng nhập nội dung chi tiết hợp lệ!");
      return false;
    }
    return true;
  }

  ///
  /// Thêm thu
  ///
  void onAddThu() {
    if (validateThu()) {
      revenueController.text = '1';
      print(timeRevenueExpenditure.text);
      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          ngayThuChi: timeRevenueExpenditure.text,
          loai: revenueController.text,
          tieuDe: contentRevenueController.text,
          soTien: moneyController.text,
          noiDung: detailContentRevenueController.text,
        ),
        onSuccess: (value) {
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        },
      );
    }
  }

  ///
  /// Check null value THÊM CHI
  ///
  bool validateChi() {
    if (timeRevenueExpenditure.text.toString().isEmpty) {
      Get.snackbar("Ngày không hợp lệ!", "Vui lòng chọn ngày hợp lệ!");
      return false;
    }
    if (contentExpenditureController.text.toString().isEmpty) {
      Get.snackbar("Nội dung chi chính không hơp lệ!",
          "Vui lòng nhập nội dung chi chính hợp lệ!");
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Get.snackbar("Số tiền không hơp lệ!", "Vui lòng nhập số tiền hợp lệ!");
      return false;
    }
    if (detailContentExpenditureController.text.toString().isEmpty) {
      Get.snackbar("Nội dung chi tiết không hơp lệ!",
          "Vui lòng nhập nội dung chi tiết hợp lệ!");
      return false;
    }
    return true;
  }

  ///
  /// Thêm thu
  ///
  void onAddChi() {
    if (validateChi()) {
      expenditureController.text = '2';
      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          ngayThuChi: timeRevenueExpenditure.text,
          loai: expenditureController.text,
          tieuDe: contentExpenditureController.text,
          soTien: moneyController.text,
          noiDung: detailContentExpenditureController.text,
        ),
        onSuccess: (value) {
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        },
      );
    }
  }
}
