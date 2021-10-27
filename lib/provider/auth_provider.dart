import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/account_request.dart';
// import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/repository/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository? authRepository = GetIt.I.get<AuthRepository>();

  AuthProvider();

  ///
  /// login
  ///
  Future<void> login({
    required AccountRequest request,
    required Function(TaiKhoanResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.login(request);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final TaiKhoanResponse account =
          TaiKhoanResponse.fromJson(results['user'] as Map<String, dynamic>);
      account.access = results['tokens']['access']['token'].toString();
      account.refresh = results['tokens']['refresh']['token'].toString();
      onSuccess(account);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// register
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
}
