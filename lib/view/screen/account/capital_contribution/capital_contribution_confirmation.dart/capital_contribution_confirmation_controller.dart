import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/routes/route_path/home_routes.dart';

class CapitalContributionConfirmationController extends GetxController {
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
      confirmLabel: 'Đồng ý',
      description: "Bạn có chắc chắn muốn góp vốn!.",
      onConfirm: () {
        EasyLoading.show(status: "Loading");
        onBack();
        Future.delayed(const Duration(seconds: 3), () {
          EasyLoading.dismiss();
          IZIDialog.showDialog(
            lable: "Xác nhận",
            confirmLabel: 'Đồng ý',
            description: "Bạn có muốn tải hợp đồng!",
            onConfirm: () {
              onToHomePage();
              onBack();
            },
            onCancel: () {
              onToHomePage();
              onBack();
            },
          );
        });
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
