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
import 'package:template/utils/alert.dart';

class V4RevenueExpenditureController extends GetxController
    with CurrencyConverter {
  //Thu chi nhân viên Provider
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  List<ThuChiNhanVienResponse> thuChiNhanVienModelList = [];
  //khai báo isLoading
  bool isLoading = true;

  //Khai báo isRevenue
  bool isRevenue = true;

  //Khai báo idChamCong
  String idChamCong = '';

  //Khai báo justOnlyClick
  bool justOnlyClick = false;

  //Set ngày hiện Tại
  String timeNow = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final timeRevenueExpenditure = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));
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
      Alert.error(message: 'Vui lòng chọn thời gian thêm thu!');
      return false;
    }
    if (contentRevenueController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung thu chính!');
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng số tiền thêm thu!');
      return false;
    }
    if (detailContentRevenueController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung thu chi tiết!');
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
      final DateTime timeA = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeRevenueExpenditure.text)
          .toString()
          .substring(0, 10));
      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
          ngayThuChi: timeA.toString(),
          loai: "1",
          tieuDe: contentRevenueController.text,
          soTien: moneyController.text.replaceAll(".", ''),
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
      Alert.error(message: 'Vui lòng chọn thời gian thêm chi!');
      return false;
    }
    if (contentExpenditureController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung chi chính!');
      return false;
    }
    if (moneyController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng số tiền thêm chi!');
      return false;
    }
    if (detailContentExpenditureController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung chi chi tiết!');
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
      final DateTime timeB = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(timeRevenueExpenditure.text)
          .toString()
          .substring(0, 10));

      thuChiNhanVienProvider.add(
        data: ThuChiNhanVienRequest(
          idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
          ngayThuChi: timeB.toString(),
          loai: "2",
          tieuDe: contentExpenditureController.text,
          soTien: moneyController.text.replaceAll(".", ''),
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
