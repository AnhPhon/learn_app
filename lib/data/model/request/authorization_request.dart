import 'dart:convert';

class AuthorizationRequest {
  final String email;
  final String password;

  AuthorizationRequest({
    required this.email,
    required this.password,
  });


  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthorizationRequest.fromMap(Map<String, dynamic> map) {
    return AuthorizationRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorizationRequest.fromJson(String source) => AuthorizationRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
