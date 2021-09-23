class UserModel {
  String? idUser;
  String? idRole;
  String? idOptionalRole;
  String? fullname;
  String? username;
  String? password;
  String? sex;
  String? avatar;
  String? born;
  String? phone;
  String? email;
  String? address;
  String? citizenIdentification;
  String? status;
  String? addressCurrent;
  String? paymentProofImage;
  String? imageCitizenIdentification;
  String? imageCitizenIdentification1;

  UserModel({
      this.idUser,
      this.idRole,
      this.idOptionalRole,
      this.fullname,
      this.username,
      this.password,
      this.sex,
      this.avatar,
      this.born,
      this.phone,
      this.email,
      this.address,
      this.citizenIdentification,
      this.status,
      this.addressCurrent,
      this.paymentProofImage,
      this.imageCitizenIdentification,
      this.imageCitizenIdentification1
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'].toString();
    idRole = json['idRole'].toString();
    idOptionalRole = json['idOptionalRole'].toString();
    fullname = json['fullname'].toString();
    username = json['username'].toString();
    password = json['password'].toString();
    sex = json['sex'].toString();
    avatar = json['avatar'].toString();
    born = json['born'].toString();
    phone = json['phone'].toString();
    email = json['email'].toString();
    address = json['address'].toString();
    citizenIdentification = json['citizenIdentification'].toString();
    status = json['status'].toString();
    addressCurrent = json['addressCurrent'].toString();
    paymentProofImage = json['paymentProofImage'].toString();
    imageCitizenIdentification = json['imageCitizenIdentification'].toString();
    imageCitizenIdentification1 = json['imageCitizenIdentification1'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['idRole'] = idRole;
    data['idOptionalRole'] = idOptionalRole;
    data['fullname'] = fullname;
    data['username'] = username;
    data['password'] = password;
    data['sex'] = sex;
    data['avatar'] = avatar;
    data['born'] = born;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['citizenIdentification'] = citizenIdentification;
    data['status'] = status;
    data['addressCurrent'] = addressCurrent;
    data['paymentProofImage'] = paymentProofImage;
    data['imageCitizenIdentification'] = imageCitizenIdentification;
    data['imageCitizenIdentification1'] = imageCitizenIdentification1;
    return data;
  }
}
