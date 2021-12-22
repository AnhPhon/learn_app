import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/helper/izi_validate.dart';

class AuthRequest extends AuthResponse{
  ///
  /// From JSON
  ///
  AuthRequest.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['id']) ? json['id'].toString() : null;
    userName = !IZIValidate.nullOrEmpty(json['userName']) ? json['userName'].toString() : null;
    password = !IZIValidate.nullOrEmpty(json['password']) ? json['password'].toString() : null;
    token = !IZIValidate.nullOrEmpty(json['token']) ? json['token'].toString() : null;
    refreshToken = !IZIValidate.nullOrEmpty(json['refreshToken']) ? json['refreshToken'].toString() : null;
  }

  ///
  /// To JSON
  ///
  @override
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
}
