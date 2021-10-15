import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';

class V4ReportTimekeepingControllter extends GetxController {
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();
  //khai báo isLoading
  bool isLoading = true;

  final reportTimekeeping =
      TextEditingController(text: DateTime.now().toString());
  final reportContent = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //

  void report() {
    baoCaoNhanVienProvider.add(
      data: BaoCaoNhanVienRequest(
        noiDung: reportContent.text,
        soTuan: reportTimekeeping.text,
      ),
      onSuccess: (value) {
        Get.back();
      },
      onError: (error) {},
    );
  }
}
