
class LienHeCongTyResponse {
  String? id;
  String? diaChi;
  String? email;
  String? soDienThoai;

  LienHeCongTyResponse({
      this.id,
      this.diaChi,
      this.email,
      this.soDienThoai});
  
  ///
  /// From JSON
  ///
  LienHeCongTyResponse.fromJson(Map<String, dynamic> json) {
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
