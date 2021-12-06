import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/verify_otp_request.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';

import '../../../di_container.dart';

class UpdatePasswordController extends GetxController {
  //Provider
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  TaiKhoanProvider userProvider = GetIt.I.get<TaiKhoanProvider>();

  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool isLoading = true;
  VerifyOtpRequest? verifyOtpRequest;

  @override
  void onInit() {
    super.onInit();
    // sl.get<SharedPreferenceHelper>().userId.then((value){
    //   userId = value;
    // });
    if(Get.arguments != null){
      verifyOtpRequest = Get.arguments as VerifyOtpRequest;
    }else{
      IZIAlert.error(message: "Xảy ra lỗi vui lòng thử lại");
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    if(validate()){
      final VerifyOtpRequest request =  VerifyOtpRequest(
        otp: verifyOtpRequest!.otp,
        resetPasswordToken: verifyOtpRequest!.resetPasswordToken, 
        newPassowrd: passwordController.text.toString()
      );
      authProvider.resetPassword(request: request, onSuccess: (){
        sl.get<SharedPreferenceHelper>().removeResetPasswordToken();
        verifyOtpRequest = null;
        Get.offAllNamed(AppRoutes.LOGIN,
           predicate: ModalRoute.withName(AppRoutes.LOGIN));
        IZIAlert.success(message: "Thay đổi mật khẩu thành công");
      }, onError: (onError){
        print("Lỗi thay đổi mật khẩu");
      });
    }
  }

  ///
  /// Validate
  ///
  bool validate() {
    if(passwordController.text.toString().isEmpty){
      IZIAlert.error(message: 'Vui lòng nhập mật khẩu mới');
      return false;
    }else if(Validate.charactersLength(passwordController.text.toString()) == false){
      IZIAlert.error(message: 'Mật khẩu ít nhất 8 ký tự');
      return false;
    }else if(Validate.oneLowerCase(passwordController.text.toString()) == false){
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 chữ thường');
      return false;
    }else if(Validate.oneUpperCase(passwordController.text.toString()) == false){
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 chữ hoa');
      return false;
    }else if(Validate.leastOneDigit(passwordController.text.toString()) == false){
      IZIAlert.error(message: 'Mật khẩu ít nhất phải có 1 số');
      return false;
    }else if(passwordController.text.toString() != repeatPasswordController.text.toString()){
      IZIAlert.error(message: 'Mật khẩu không trùng khớp');
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }
  
  
}
