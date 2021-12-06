import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';

class ForgotPasswordController extends GetxController {
  final phoneController = TextEditingController();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  
  AuthModel? auth;
  bool isLoading = true;

  ///
  /// on button OTP verifier tap
  ///
  void onOTPVerifierTap() {
    if(phoneValidate()){
      authProvider.forgetPassword(phone: {
        'phone':phoneController.text.toString()
      }, onSuccess: (data){
        sl.get<SharedPreferenceHelper>().saveResetPasswordToken(data).then((value){
          Get.toNamed(AppRoutes.OTP_VERIFIER);
        });
      }, onError: (onError){
        print("Lỗi xác thực đổi mật khẩu: $onError");
      });
    }
  }

  ///
  /// Check validate phone
  ///
  bool phoneValidate(){
    if (phoneController.text == '') {
      IZIAlert.error(message: "Vui lòng điền đầy đủ số điện thoại và mật khẩu");
      return false;
    } else if(!Validate.phone(phoneController.text.toString())){
      IZIAlert.error(message: "Số điện thoại không hợp lệ");
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    phoneController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
