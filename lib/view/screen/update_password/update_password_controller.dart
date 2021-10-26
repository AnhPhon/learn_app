import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

import '../../../di_container.dart';

class UpdatePasswordController extends GetxController {
  //Provider
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  TaiKhoanProvider userProvider = GetIt.I.get<TaiKhoanProvider>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;

  String? userId;

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value){
      userId = value;
    });
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    // Đăng ký tài khoản
    final TaiKhoanRequest account = TaiKhoanRequest();
    account.id = userId;
    account.matKhau = passwordController.text.toString();
    userProvider.update(data: account, onSuccess: (onSuccess){
      Alert.success(message: "Đăng ký tài khoản thành công");
      // remove all route but not login.
      Get.offAllNamed(AppRoutes.LOGIN,
          predicate: ModalRoute.withName(AppRoutes.LOGIN));
    }, onError: (onError){
      Alert.error(message:"Đã xảy ra lỗi vui lòng thử lại");
    });
  }
}
