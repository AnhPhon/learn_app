
class LienHeCongTyResponse {
  String? id;
  String? diaChi;
  String? email;
  String? soDienThoai;

  String? createdAt;
  String? updatedAt;

  LienHeCongTyResponse({
      this.id,
      this.diaChi,
      this.email,
      this.soDienThoai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  LienHeCongTyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    diaChi = json['diaChi'].toString();
    email = json['email'].toString();
    soDienThoai = json['soDienThoai'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null email
    if (email != null) data['email'] = email; 

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai; 


    return data;
  }
}
