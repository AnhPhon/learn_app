class LienHeCongTyRequest {
  String? id;
  String? diaChi;
  String? email;
  String? soDienThoai;
  LienHeCongTyRequest({
      this.id,
      this.diaChi,
      this.email,
      this.soDienThoai});
  
  ///
  /// From JSON
  ///
  LienHeCongTyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    diaChi = json['diaChi'].toString();
    email = json['email'].toString();
    soDienThoai = json['soDienThoai'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diaChi'] = diaChi;
    data['email'] = email;
    data['soDienThoai'] = soDienThoai;
    return data;
  }
}
