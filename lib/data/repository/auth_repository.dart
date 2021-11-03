// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/account_request.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/request/verify_otp_request.dart';
// import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AuthRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();
  SharedPreferenceHelper? sharedPreferences =
      GetIt.I.get<SharedPreferenceHelper>();

  AuthRepository();

  ///
  /// Insert user to database
  ///
  // Future<ApiResponse> registration(UserModel data) async {
  //   try {
  //     final response = await dioClient!.post('/users', data: data.toJson());
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  ///
  /// Login with email
  ///
  Future<ApiResponse> login(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/login', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// register
  ///
  Future<ApiResponse> register(TaiKhoanRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/register', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Đăng nhập bằng tài khoản số điện thoại
  ///
  Future<ApiResponse> loginAccount(AccountRequest request) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/login', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// Đăng ký bằng tài khoản số điện thoại
  ///
  Future<ApiResponse> registerAccount(TaiKhoanRequest request) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/register', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Đăng xuất tài khoản số điện thoại
  ///
  Future<ApiResponse> logoutAccount(dynamic request) async {
    try {
      final response =
          await dioClient!.post('/auth/logout', data: json.encode(request) );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// Forget password
  ///
  Future<ApiResponse> forgetPassword(dynamic phone) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/forgot-password', data: json.encode(phone));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// Verify otp
  ///
  Future<ApiResponse> verifyOTP(VerifyOtpRequest request) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/verifier-otp', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// reset pass
  ///
  Future<ApiResponse> resetPassword(VerifyOtpRequest request) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/reset-password', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// send otp
  ///
  Future<ApiResponse> sendOTP(dynamic phone) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/sent-otp', data: json.encode(phone));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<ApiResponse> updateToken() async {
  //   try {
  //     final String _deviceToken = await getDeviceToken();
  //     FirebaseMessaging.instance.subscribeToTopic(app_constants.TOPIC);
  //     final Response response = await dioClient.post(
  //       app_constants.TOKEN_URI,
  //       data: {'_method': 'put', 'cm_firebase_token': _deviceToken},
  //     );
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  ///
  /// get device token
  ///
  // Future<String> getDeviceToken() async {
  //   final String _deviceToken =
  //       FirebaseMessaging.instance.getToken().toString();
  //   print('--------Device Token----------  $_deviceToken');
  //   return _deviceToken;
  // }

  ///
  /// save User Token
  ///
  Future<void> saveUserToken(String token) async {
    dioClient!.token = token;
    dioClient!.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences!.saveJwtToken(token);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// getUserToken
  ///
  String getUserToken() {
    return sharedPreferences!.jwtToken.toString();
  }

  ///
  /// isLoggedIn
  ///
  bool isLoggedIn() {
    return sharedPreferences!.containsKey();
  }

  ///
  /// clearSharedData
  ///
  Future<bool> clearSharedData() async {
    sharedPreferences!.removeJwtToken();
    // FirebaseMessaging.instance.unsubscribeFromTopic(app_constants.TOPIC);
    return true;
  }

  ///
  /// for  Remember Username
  ///
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      sharedPreferences!.saveUsername(email);
      sharedPreferences!.savePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  // String getUserEmail() {
  //   return sharedPreferences.getString(app_constants.USER_EMAIL) ?? '';
  // }
  //
  // String getUserPassword() {
  //   return sharedPreferences.getString(app_constants.USER_PASSWORD) ?? '';
  // }
  //
  // Future<bool> clearUserEmailAndPassword() async {
  //   await sharedPreferences.remove(app_constants.USER_PASSWORD);
  //   final result = await sharedPreferences.remove(app_constants.USER_EMAIL);
  //   return result;
  // }
  //
  // Future<ApiResponse> forgetPassword(String email) async {
  //   try {
  //     final Response response = await dioClient
  //         .post(app_constants.FORGET_PASSWORD_URI, data: {'email': email});
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
}
