import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/login/login_page.dart';

class UpdatePasswordController extends GetxController {
  // AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  // UserProvider userProvider = GetIt.I.get<UserProvider>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    // Get.removeRoute();
    Get.offAllNamed(AppRoutes.LOGIN); 
  }
}

// A -> B -> C -> D -> A
