class UsersModel {
  bool? isEmailVerified;
  String? password;
  String? idUser;
  String? idRole;
  String? idOptionalRole;
  String? fullname;
  String? username;
  String? sex;
  String? avatar;
  String? born;
  String? phone;
  String? email;
  String? address;
  String? citizenIdentification;
  String? incomeCurrent;
  String? percentCondition;
  String? status;
  String? imageCitizenIdentification;
  String? imageCitizenIdentification1;
  String? paymentProofImage;

  UsersModel({
    this.isEmailVerified,
    this.password,
    this.idUser,
    this.idRole,
    this.idOptionalRole,
    this.fullname,
    this.username,
    this.sex,
    this.avatar,
    this.born,
    this.phone,
    this.email,
    this.address,
    this.citizenIdentification,
    this.incomeCurrent,
    this.percentCondition,
    this.status,
    this.imageCitizenIdentification,
    this.imageCitizenIdentification1,
    this.paymentProofImage,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        isEmailVerified: json['isEmailVerified'] as bool?,
        password: json['password'] as String?,
        idUser: json['idUser'] as String?,
        idRole: json['idRole'] as String?,
        idOptionalRole: json['idOptionalRole'] as String?,
        fullname: json['fullname'] as String?,
        username: json['username'] as String?,
        sex: json['sex'] as String?,
        avatar: json['avatar'] as String?,
        born: json['born'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        address: json['address'] as String?,
        citizenIdentification: json['citizenIdentification'] as String?,
        incomeCurrent: json['incomeCurrent'] as String?,
        percentCondition: json['percentCondition'] as String?,
        status: json['status'] as String?,
        imageCitizenIdentification:
            json['imageCitizenIdentification'] as String?,
        imageCitizenIdentification1:
            json['imageCitizenIdentification1'] as String?,
        paymentProofImage: json['paymentProofImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'isEmailVerified': isEmailVerified,
        'password': password,
        'idUser': idUser,
        'idRole': idRole,
        'idOptionalRole': idOptionalRole,
        'fullname': fullname,
        'username': username,
        'sex': sex,
        'avatar': avatar,
        'born': born,
        'phone': phone,
        'email': email,
        'address': address,
        'citizenIdentification': citizenIdentification,
        'incomeCurrent': incomeCurrent,
        'percentCondition': percentCondition,
        'status': status,
        'imageCitizenIdentification': imageCitizenIdentification,
        'imageCitizenIdentification1': imageCitizenIdentification1,
        'paymentProofImage': paymentProofImage,
      };
}
