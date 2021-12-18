import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/routes/route_path/home_routes.dart';

class ContractDetailController extends GetxController {
  Uint8List? signature;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      signature = Get.arguments as Uint8List;
    }
  }

  void onConfirm() {

    IZIDialog.showDialog(
      lable: "Xác nhận",
      description: "Số tiền hợp đồng: 12.000.000 đ"
"\nSố tiền đã đối ứng: 4.000.000 đ"
"\nSố tiền hoàn trả đối ứng: 2.000.000 đ"
"\nSố tiền phụ thêm: 30.000 đ"
"\nSố tiền lãi : 120.000 đ"
"\nSố tiền phạt: 1.000.000 đ (rút trước hạn)"
"\nSố tiền thực lãnh: 9.150.000 đ",
      onConfirm: () {
        onToHomePage();
        onBack();
      },
      onCancel: () {
        onBack();
      },
    );
  }
  

  void onToHomePage() {
    Get.offAllNamed(
      HomeRoutes.DASH_BOARD,
      predicate: ModalRoute.withName(
        HomeRoutes.DASH_BOARD,
      ),
    );
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
