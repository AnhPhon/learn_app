import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/request/account_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/loai_tai_khoan_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/validate.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();
  final LoaiTaiKhoanProvider typeAccountProvider =
      GetIt.I.get<LoaiTaiKhoanProvider>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;

  bool isLoading = true;

  @override
  void onInit() {
    // Em cập nhật lại rồi nha. Khách Hàng:
    // 0111111111
    // KhachHang1
    // Thợ Thầu
    // 0222222222
    // ThoThau1
    // Đại Lý:
    // 0333333333
    // DaiLy123
    phoneController.text = '0111111111';
    passwordController.text = 'KhachHang1';
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
    resetForm();
  }

  ///
  /// on button register tap
  ///
  void onBtnRegisterTap() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  ///
  /// on button register tap
  ///
  void onBtnLoginEmployee() {
    Get.offAndToNamed(AppRoutes.LOGIN_EMPLOYEE);
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
    if (phoneController.text == '' || passwordController.text == '') {
      Alert.error(message: "Vui lòng điền đầy đủ số điện thoại và mật khẩu");
      return false;
    } else if(!Validate.phone(phoneController.text.toString())){
      Alert.error(message: "Số điện thoại không hợp lệ");
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
      final AccountRequest accountRequest = AccountRequest();
      accountRequest.soDienThoai = phoneController.text.toString();
      accountRequest.matKhau = passwordController.text.toString();
      authProvider.loginAccount(
          request: accountRequest,
          onSuccess: (account) {
            // save info token and info user
            sl.get<SharedPreferenceHelper>().saveUserId(account.id!);
            sl.get<SharedPreferenceHelper>().saveJwtToken(account.access!);
            sl.get<SharedPreferenceHelper>().saveRefreshToken(account.refresh!);

            sl.get<SharedPreferenceHelper>()
                  .saveTypeAccount(account.idLoaiTaiKhoan!.toString());
              
              // Nếu người dùng remember thì lần sau tự động đăng nhập vào luôn
              sl.get<SharedPreferenceHelper>().saveTypeAccount(account.idLoaiTaiKhoan!.toString());
              if(isRemember){
                sl.get<SharedPreferenceHelper>().saveIsLogin(id:true);
                sl.get<SharedPreferenceHelper>().saveRememberAccount(isRemember);
              }

              // Kiểm tra loại tài khoản người dùng
              if(account.idLoaiTaiKhoan != null){
                if (account.idLoaiTaiKhoan == KHACH_HANG) {
                  EasyLoading.dismiss();
                  Get.offAndToNamed(AppRoutes.V1_DASHBOARD);
                  return;
                } else if (account.idLoaiTaiKhoan == THO_THAU) {
                  EasyLoading.dismiss();
                  Get.offAndToNamed(AppRoutes.V2_DASHBOARD);
                  return;   
                } else if (account.idLoaiTaiKhoan == DAI_LY) {
                  EasyLoading.dismiss();
                  Get.offAndToNamed(AppRoutes.V3_DASHBOARD);
                  return;
                }
                else{
                  //Nếu id loại tài khoản mà không thuộc nhóm loại tai khoản thì không thể đăng nhập
                  EasyLoading.dismiss();
                  Alert.error(message: "Đã xảy ra lỗi vui lòng thử lại!");
                }
              }else{
                // Nếu loại tải khoản bằng null thì không thể đăng nhập vào
                EasyLoading.dismiss();
                Alert.error(message: "Đã xảy ra lỗi vui lòng thử lại!");
              }
          },onError: (error) {
            Alert.error(
                message:
                    "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
            EasyLoading.dismiss();
            print("Lỗi đăng nhập onError $error");
            update();
          });
    }
  }

  ///
  /// Reset form
  ///
  void resetForm(){
    phoneController.text = '' ;
    passwordController.text = '';
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
