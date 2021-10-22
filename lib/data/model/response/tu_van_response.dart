
class TuVanResponse {
  String? id;
  String? idTaiKhoan;
  String? chuDeTuVan;
  String? trangThai;

  String? createdAt;
  String? updatedAt;

  TuVanResponse({
      this.id,
      this.idTaiKhoan,
      this.chuDeTuVan,
      this.trangThai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  TuVanResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    chuDeTuVan = json['chuDeTuVan'].toString();
    trangThai = json['trangThai'].toString();

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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null chuDeTuVan
    if (chuDeTuVan != null) data['chuDeTuVan'] = chuDeTuVan; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
