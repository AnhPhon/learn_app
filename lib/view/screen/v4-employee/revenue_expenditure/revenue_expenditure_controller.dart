import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/thu_chi_nhan_vien_request.dart';
import 'package:template/data/model/response/thu_chi_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/nhan_vien_provider.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';

class V4RevenueExpenditureController extends GetxController {
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  List<ThuChiNhanVienResponse> thuChiNhanVienModelList = [];

  ThuChiNhanVienResponse? thuChiNhanVien;
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
    revenueController.text = "1";
    timeRevenueExpenditure.text =
        DateConverter.readMongoToString(timeRevenueExpenditure.text);
    thuChiNhanVienProvider.add(
      data: ThuChiNhanVienRequest(
        loai: revenueController.text,
        tieuDe: contentRevenueController.text,
        soTien: moneyController.text,
        noiDung: detailContentRevenueController.text,
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
