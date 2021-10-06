class LienHeCongTyModel {
  String? diaChi;
  String? email;
  String? soDienThoai;

  LienHeCongTyModel({
      this.diaChi,
      this.email,
      this.soDienThoai
      });

  LienHeCongTyModel.fromJson(Map<String, dynamic> json) {
    diaChi = json['diaChi'].toString();
    email = json['email'].toString();
    soDienThoai = json['soDienThoai'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['soDienThoai'] = soDienThoai;
    return data;
  }
}
