import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/routes/app_routes.dart';

class OTPVerifierController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;

  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    // init error pin code controller
    errorController = StreamController<ErrorAnimationType>();

    super.onInit();
  }

  @override
  void onClose() {
    // close error pin code controller
    errorController!.close();

    super.onClose();
  }

  ///
  /// on button complete tap
  ///
  void onBtnCompleteTap() {
    print('asdf ${textEditingController.text}');
    errorController!.add(ErrorAnimationType.shake);
    // Nếu chính xác OPT thì => true else false
    Get.back(result: true);

  }
}
