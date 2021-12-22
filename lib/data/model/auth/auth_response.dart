import 'package:template/helper/izi_validate.dart';

class AuthResponse {
  String? id;
  String? userName;
  String? password;
  String? token;
  String? refreshToken;
  AuthResponse({
    this.id,
    this.userName,
    this.password,
    this.token,
    this.refreshToken,
  });

  ///
  /// From JSON
  ///
  AuthResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    userName = !IZIValidate.nullOrEmpty(json['userName']) ? json['userName'].toString() : null;
    password = !IZIValidate.nullOrEmpty(json['password']) ? json['password'].toString() : null;
    token = !IZIValidate.nullOrEmpty(json['token']) ? json['token'].toString() : null;
    refreshToken = !IZIValidate.nullOrEmpty(json['refreshToken']) ? json['refreshToken'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;

    // check null userName
    if (!IZIValidate.nullOrEmpty(userName)) data['userName'] = userName;

    // check null password
    if (!IZIValidate.nullOrEmpty(password)) data['password'] = password;

    // check null token
    if (!IZIValidate.nullOrEmpty(token)) data['token'] = token;

    // check null refreshToken
    if (!IZIValidate.nullOrEmpty(refreshToken)) data['refreshToken'] = refreshToken;

    return data;
  }

  @override
  String toString() {
    return 'AuthResponse(id: $id, userName: $userName, password: $password, token: $token, refreshToken: $refreshToken)';
  }
}
