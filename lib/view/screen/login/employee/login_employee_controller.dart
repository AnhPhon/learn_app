import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/account_request.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/loai_tai_khoan_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
// import 'package:template/provider/auth_provider.dart';
// import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class LoginEmployeeController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();
  final LoaiTaiKhoanProvider typeAccountProvider =
      GetIt.I.get<LoaiTaiKhoanProvider>();

  final emailController = TextEditingController(text: "admin@gmail.com");
  final passwordController = TextEditingController(text: "password");
  bool isRemember = false;

  ///
  /// on button forgot password tap
  ///
  void onBtnForgotPasswordTap() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
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
  /// onBtnLogin
  ///
  void onBtnLogin() {
    Get.offAndToNamed(AppRoutes.LOGIN);
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    onLogin();
  }

  ///
  /// Validate login
  ///
  bool onValidateLogin() {
    //validate infomation username password
    if (emailController.text == '' || passwordController.text == '') {
      Alert.info(message: "Vui lòng điền đầy đủ email và mật khẩu");
      return false;
    } else if (!Validate.email(emailController.text.toString())) {
      Alert.info(message: "Địa chỉ email không hợp lệ !");
      return false;
    }
    return true;
  }

  ///
  /// Login
  ///
  void onLogin() {
    if (onValidateLogin()) {
      EasyLoading.show(status: "Đăng nhập");
      final AuthRequest authRequest = AuthRequest();
      authRequest.email = emailController.text.toString();
      authRequest.password = passwordController.text.toString();
      authProvider.login(
          request: authRequest,
          onSuccess: (account) {
            // save info token and info user
            sl.get<SharedPreferenceHelper>().saveUserId(account.id!);
            sl.get<SharedPreferenceHelper>().saveJwtToken(account.access!);
            sl.get<SharedPreferenceHelper>().saveRefreshToken(account.refresh!);

            sl
                .get<SharedPreferenceHelper>()
                .saveUsername(account.email.toString());

            print(account.email.toString());
            // sl
            //     .get<SharedPreferenceHelper>()
            //     .saveUsername(emailController.text.toString());
            // print(emailController.text.toString());
            sl
                .get<SharedPreferenceHelper>()
                .savePassword(account.matKhau.toString());
            print(account.matKhau.toString());
            // sl.get<SharedPreferenceHelper>().saveUsername(username)
            // if(isRemember){
            //   sl.get<SharedPreferenceHelper>().saveTypeAccount(account.idRole!);
            //   sl.get<SharedPreferenceHelper>().saveRememberAccount(isRemember);
            // }
            sl.get<SharedPreferenceHelper>().saveRememberAccount(true);
            sl.get<SharedPreferenceHelper>().saveIsLogin(id: true);
            sl.get<SharedPreferenceHelper>().saveTypeAccount(NHAN_VIEN);

            EasyLoading.dismiss();
            Get.offAndToNamed(AppRoutes.V4_DASHBOARD);
          },
          onError: (error) {
            Alert.error(
                message:
                    "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
            EasyLoading.dismiss();
            print("Lỗi đăng nhập onError $error");
            update();
          });
    }
  }
}
