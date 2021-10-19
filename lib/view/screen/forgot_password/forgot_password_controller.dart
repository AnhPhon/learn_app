import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final usernameController = TextEditingController();
  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// on button OTP verifier tap
  ///
  void onOTPVerifierTap() {
    Get.toNamed(AppRoutes.OTP_VERIFIER);
  }
}
