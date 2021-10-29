import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/verify_otp_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class OTPVerifierController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  AuthModel? auth;
  bool isLoading = true;

  /// Kiểm tra đăng ký hay quên mật khẩu
  bool isRegister = false;

  @override
  void onInit() {
    // init error pin code controller
    if(Get.arguments != null){
      // isRegister = true;
      isRegister = Get.arguments as bool;
    }
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
    validateOTP();
    if(hasError == false) {
      sl.get<SharedPreferenceHelper>().resetPasswordToken.then((val){
        final VerifyOtpRequest request = VerifyOtpRequest(otp: textEditingController.text.toString(), resetPasswordToken: val);
        authProvider.verifyOTP(request: request, onSuccess: (status){
          if(status){
            if(isRegister){
              Get.back(result: true);
            }else{
              Get.offAndToNamed(AppRoutes.UPDATE_PASSWORD, arguments: request);
            }
          }else{
            Alert.error(message: "Lỗi xác thực otp vui lòng thử lại");
          }
        }, onError: (onError){
          print("Lỗi xác thực otp $onError");
        });
      });
    }
  }
    
  

  ///
  /// Validate
  ///
  void validateOTP() {
    formKey.currentState!.validate();
    if (textEditingController.text.length != 6) {
      errorController!.add(ErrorAnimationType
          .shake);
      hasError = true;
      update();
    } else {
      hasError = false;
      update();
    }
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    super.dispose();
  }

}
