import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/account_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
// import 'package:template/provider/auth_provider.dart';
// import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    phoneController.text = '2';
    // passwordController.text = 'password';
    super.onInit();
  }

  ///
  /// on checkbox remember click
  ///
  void onCheckBoxRememberClick() {
    if (isRemember) {
      isRemember = false;
    } else {
      isRemember = true;
    }
    update();
  }

  ///
  /// on button forgot password tap
  ///
  void onBtnForgotPasswordTap() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  ///
  /// on button register tap
  ///
  void onBtnRegisterTap() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    sl.get<SharedPreferenceHelper>().saveUserId("616d7c0dc48e736e333ef26b");

    if (phoneController.text == '1') {
      Get.toNamed(AppRoutes.V1_DASHBOARD);
    } else if (phoneController.text == '2') {
      Get.toNamed(AppRoutes.V2_DASHBOARD);
    } else if (phoneController.text == '3') {
      Get.toNamed(AppRoutes.V3_DASHBOARD);
    } else if (phoneController.text == '4') {
      Get.toNamed(AppRoutes.V4_DASHBOARD);
    } else {}
  }


  ///
  /// Validate login
  ///
  bool onValidateLogin(){
    //validate infomation username password
    final RegExp phoneRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (phoneController.text == '' || passwordController.text == '') {
      Alert.error(message: "Vui lòng điền đầy đủ số điện thoại và mật khẩu");
      return false;
    } else if(phoneRegExp.hasMatch(phoneController.text.toString())){
      Alert.error(message: "Số điện thoại không hợp lệ");
      return false;
    }
    return true;
  }

  ///
  /// Login
  ///
  void onLogin(){
    if(onValidateLogin()){
      final AccountRequest accountRequest = AccountRequest();
      accountRequest.soDienThoai = phoneController.text.toString();
      accountRequest.matKhau = passwordController.text.toString();
      authProvider.login(
        request: accountRequest,
        onSuccess: (account) {
          isLoading = false;
          auth = auth;

          // save info token and info user
          sl.get<SharedPreferenceHelper>().saveUserId(account.id!);
          sl.get<SharedPreferenceHelper>().saveJwtToken(account.access!);
          sl.get<SharedPreferenceHelper>().saveRefreshToken(account.refresh!);
          sl.get<SharedPreferenceHelper>().saveIsLogin(id:true);

          print(account.toJson());

          update();
          //Get.toNamed(AppRoutes.DASHBOARD);
        },
        onError: (error) {
          isLoading = false;
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        }
      );
    }
  }

}
