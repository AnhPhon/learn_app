import 'dart:convert';



class VerifyOtpRequest {
  String? resetPasswordToken;
  final String otp;
  String? newPassowrd;
  VerifyOtpRequest({
    this.resetPasswordToken,
    required this.otp,
    this.newPassowrd
  });


  Map<String, dynamic> toMap() {
    return {
      if(resetPasswordToken != null)'resetPasswordToken': resetPasswordToken,
      'otp': otp,
      if(newPassowrd != null)'newPassword':newPassowrd
    };
  }

  factory VerifyOtpRequest.fromMap(Map<String, dynamic> map) {
    return VerifyOtpRequest(
      resetPasswordToken: map['resetPasswordToken'] as String,
      otp: map['otp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpRequest.fromJson(String source) => VerifyOtpRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
