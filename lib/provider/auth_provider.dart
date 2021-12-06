import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/account_request.dart';
// import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/request/verify_otp_request.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/repository/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository? authRepository = GetIt.I.get<AuthRepository>();

  AuthProvider();

  ///
  /// login with employee
  ///
  Future<void> login({
    required AuthRequest request,
    required Function(AuthModel auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.login(request);
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthModel authResponse =
          AuthModel.fromJson(results['nhanVien'] as Map<String, dynamic>);
      authResponse.access = results['tokens']['access']['token'].toString();
      authResponse.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// login to salary with employee
  ///
  Future<void> loginToSalaryInEmployee({
    required AuthRequest request,
    required Function(AuthModel auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await authRepository!.loginSalaryInEmployee(request);
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthModel authResponse =
          AuthModel.fromJson(results['nhanVien'] as Map<String, dynamic>);
      authResponse.access = results['tokens']['access']['token'].toString();
      authResponse.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// login
  ///
  Future<void> register({
    required TaiKhoanRequest request,
    required Function(AuthModel auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.register(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthModel authResponse =
          AuthModel.fromJson(results['user'] as Map<String, dynamic>);
      authResponse.access = results['tokens']['access']['token'].toString();
      authResponse.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  /// Dăng nhập bằng ttài khoản (SĐT)

  ///
  /// Dăng nhập bằng ttài khoản (SĐT)
  ///
  Future<void> loginAccount({
    required AccountRequest request,
    required Function(TaiKhoanResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.loginAccount(request);
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
      //EasyLoading.dismiss();
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final TaiKhoanResponse account = TaiKhoanResponse.fromJson(
          results['taiKhoan'] as Map<String, dynamic>);
      account.access = results['tokens']['access']['token'].toString();
      account.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(account);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Đăng ký tài khoản (SĐT)
  ///
  Future<void> registerAccount({
    required TaiKhoanRequest request,
    required Function(TaiKhoanResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await authRepository!.registerAccount(request);
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
      //EasyLoading.dismiss();
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final TaiKhoanResponse account = TaiKhoanResponse.fromJson(
          results['taiKhoan'] as Map<String, dynamic>);
      account.access = results['tokens']['access']['token'].toString();
      account.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(account);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Dăng xuất bằng ttài khoản (SĐT)
  ///
  Future<void> logoutAccount({
    required dynamic request,
    required Function(bool status) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await authRepository!.logoutAccount(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      onSuccess(true);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Quên mật khẩu
  ///
  Future<void> forgetPassword({
    required dynamic phone,
    required Function(String data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.forgetPassword(phone);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      // final TaiKhoanResponse account = TaiKhoanResponse();
      // account.resetPasswordToken= results['resetPasswordToken'].toString();
      final String resetPasswordToken =
          results['resetPasswordToken'].toString();
      print("Token: ${results['otp'].toString()}");
      onSuccess(resetPasswordToken);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Verify OTP
  ///
  Future<void> verifyOTP({
    required VerifyOtpRequest request,
    required Function(bool data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.verifyOTP(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final bool status = results['status'] as bool;
      onSuccess(status);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// reset passowrd
  ///
  Future<void> resetPassword({
    required VerifyOtpRequest request,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await authRepository!.resetPassword(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      onSuccess();
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// send otp
  ///
  Future<void> sendOTP({
    required dynamic phone,
    required Function(String registerToken) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.sendOTP(phone);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      print(apiResponse.response.data['otp']);
      onSuccess(results['registerToken'] as String);
    } else {
      onError(apiResponse.error);
    }
  }
}
