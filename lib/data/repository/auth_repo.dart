import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/login_model.dart';
import 'package:template/data/model/body/register_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  // Future<ApiResponse> registration(RegisterModel register) async {
  //   try {
  //     final Response response = await dioClient.post(
  //       app_constants.REGISTRATION_URI,
  //       data: register.toJson(),
  //     );
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      final Response response = await dioClient.post(
        app_constants.login_uri,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //
  // Future<ApiResponse> updateToken() async {
  //   try {
  //     final String _deviceToken = await _getDeviceToken();
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
  //
  // Future<String> _getDeviceToken() async {
  //   final String _deviceToken =
  //       FirebaseMessaging.instance.getToken().toString();
  //   print('--------Device Token----------  $_deviceToken');
  //   return _deviceToken;
  // }
  //
  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(app_constants.TOKEN, token);
    } catch (e) {
      rethrow;
    }
  }

  // String getUserToken() {
  //   return sharedPreferences.getString(app_constants.TOKEN) ?? '';
  // }
  //
  // bool isLoggedIn() {
  //   return sharedPreferences.containsKey(app_constants.TOKEN);
  // }
  //
  // Future<bool> clearSharedData() async {
  //   //sharedPreferences.remove(app_constants.CART_LIST);
  //   sharedPreferences.remove(app_constants.TOKEN);
  //   sharedPreferences.remove(app_constants.USER);
  //   FirebaseMessaging.instance.unsubscribeFromTopic(app_constants.TOPIC);
  //   return true;
  // }
  //
  // // for  Remember Email
  // Future<void> saveUserEmailAndPassword(String email, String password) async {
  //   try {
  //     await sharedPreferences.setString(app_constants.USER_PASSWORD, password);
  //     await sharedPreferences.setString(app_constants.USER_EMAIL, email);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
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
