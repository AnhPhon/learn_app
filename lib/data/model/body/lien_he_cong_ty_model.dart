
class LienHeCongTyModel {
  String? diaChi;
  String? email;
  String? soDienThoai;

  LienHeCongTyModel({
      this.diaChi,
      this.email,
      this.soDienThoai});
  
  ///
  /// From JSON
  ///
  LienHeCongTyModel.fromJson(Map<String, dynamic> json) {
    diaChi = json['diaChi'].toString();
    email = json['email'].toString();
    soDienThoai = json['soDienThoai'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null email
    if (email != null) data['email'] = email; 

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai; 


    return data;
  }
}
