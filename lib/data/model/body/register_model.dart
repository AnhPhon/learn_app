class RegisterModel {
  String? email;
  String? password;
  String? fName;
  String? lName;
  String? phone;

  RegisterModel({this.email, this.password, this.fName, this.lName, this.phone});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'].toString();
    password = json['password'].toString();
    fName = json['f_name'].toString();
    lName = json['l_name'].toString();
    phone = json['phone'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    return data;
  }
}
