class ViTienRequest {
  String? id;
  String? idTaiKhoan;
  String? tongTien;
  String? trangThai;

  ViTienRequest({
      this.id,
      this.idTaiKhoan,
      this.tongTien,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  ViTienRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    tongTien = json['tongTien'].toString();
    trangThai = json['trangThai'].toString();
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

    // check null tongTien
    if (tongTien != null) data['tongTien'] = tongTien; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
