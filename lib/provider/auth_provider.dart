import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/login_model.dart';
import 'package:template/data/model/body/register_model.dart';
import 'package:template/data/model/body/users_model.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/base/error_response.dart';
import 'package:template/data/model/response/response_model.dart';
import 'package:template/data/repository/auth_repo.dart';
import 'package:template/helper/api_checker.dart';

class AuthProvider {
  AuthRepo? authRepo = GetIt.I.get<AuthRepo>();
  AuthProvider();

  //login
  Future login(
      {required Function(List<UsersModel> dreamOfNumber) onSuccess,
      required Function(dynamic error) onError,
      required LoginModel loginBody}) async {
    final ApiResponse apiResponse = await authRepo!.login(loginBody);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      final String token =
          apiResponse.response.data["tokens"]["access"]["token"].toString();
      authRepo!.saveUserToken(token);
    } else {
      onError(apiResponse.error);
    }
  }
}
