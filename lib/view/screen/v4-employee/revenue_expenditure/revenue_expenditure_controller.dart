import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/thu_chi_nhan_vien_request.dart';
import 'package:template/data/model/response/thu_chi_nhan_vien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V4RevenueExpenditureController extends GetxController
    with CurrencyConverter {
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  List<ThuChiNhanVienResponse> thuChiNhanVienModelList = [];
  //khai báo isLoading
  bool isLoading = true;

  bool isRevenue = true;

  String idChamCong = '';

  bool justOnlyClick = false;

  //Set ngày hiện Tại
  String timeNow = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final timeRevenueExpenditure = TextEditingController();
  final revenueController = TextEditingController(text: "Thêm thu");
  final expenditureController = TextEditingController(text: "Thêm chi");
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
      Get.snackbar(
        "Ngày không hợp lệ!", // title
        "Vui lòng chọn ngày hợp lệ!", // message
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (contentRevenueController.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung thu chính không hơp lệ!", // title
        "Vui lòng nhập nội dung thi chính hợp lệ!", // message
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Get.snackbar(
        "Số tiền không hơp lệ!",
        "Vui lòng nhập số tiền hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );

      return false;
    }
    if (detailContentRevenueController.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung chi tiết không hơp lệ!",
        "Vui lòng nhập nội dung chi tiết hợp lệ!",
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
  /// Thêm thu
  ///
  Future<void> onAddThu() async {
    if (validateThu() && justOnlyClick == false) {
      justOnlyClick = true;
      revenueController.text = '1';
      final DateTime timeA = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeRevenueExpenditure.text)
          .toString()
          .substring(0, 10));
      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
          ngayThuChi: timeA.toString(),
          loai: revenueController.text,
          tieuDe: contentRevenueController.text,
          soTien: moneyController.text.replaceAll(RegExp(','), ''),
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
      Get.snackbar(
        "Ngày không hợp lệ!",
        "Vui lòng chọn ngày hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (contentExpenditureController.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung chi chính không hơp lệ!",
        "Vui lòng nhập nội dung chi chính hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Get.snackbar(
        "Số tiền không hơp lệ!",
        "Vui lòng nhập số tiền hợp lệ!",
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (detailContentExpenditureController.text.toString().isEmpty) {
      Get.snackbar(
        "Nội dung chi tiết không hơp lệ!",
        "Vui lòng nhập nội dung chi tiết hợp lệ!",
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
  /// Thêm thu
  ///
  Future<void> onAddChi() async {
    if (validateChi() && justOnlyClick == false) {
      justOnlyClick = true;
      expenditureController.text = '2';
      final DateTime timeB = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeRevenueExpenditure.text)
          .toString()
          .substring(0, 10));

      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
          ngayThuChi: timeB.toString(),
          loai: expenditureController.text,
          tieuDe: contentExpenditureController.text,
          soTien: moneyController.text.replaceAll(RegExp(','), ''),
          noiDung: detailContentExpenditureController.text,
        ),
        onSuccess: (value) {
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }
}
