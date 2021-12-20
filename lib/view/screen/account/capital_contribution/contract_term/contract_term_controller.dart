import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/account_routes.dart';

class ContractTermController extends GetxController {
  final SignatureController controllerSign = SignatureController();

  final List<String> contractTypes = [
    'TST 3 triệu 2',
    'TST 3 triệu 5',
    'TST 3 triệu 10',
  ];
  // Variable
  String? contractType;
  Uint8List? signature;

  Future<Uint8List?> onSign() async {
    return exportSignature();
  }

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      points: controllerSign.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();
    if (IZIValidate.nullOrEmpty(signature)) {
      return null;
    }
    return signature!;
  }

  void onChangedContractType(String val) {
    contractType = val;
    update();
  }

  void onConfirm() {
    onSign().then(
      (val) {
        signature = val;
        update();
        if (signature == null) {
          IZIAlert.error(message: "Vui lòng ký tên");
          return;
        }
        final image = File.fromRawPath(signature!);
        //base64Decode(source)
        Get.toNamed(
          AccountRoutes.CAPITAL_CONTRIBUTION_CONFIRMATION,
          arguments: signature,
        );
      },
    );
  }

  void onClearSign() {
    controllerSign.clear();
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    controllerSign.dispose();
  }
}
