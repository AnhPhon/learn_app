class DanhSachLuuTinTuyenDungRequest {
  String? id;
  String? idTaiKhoan;
  String? idTuyenDung;

  DanhSachLuuTinTuyenDungRequest({
      this.id,
      this.idTaiKhoan,
      this.idTuyenDung});
  
  ///
  /// From JSON
  ///
  DanhSachLuuTinTuyenDungRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
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

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 


    return data;
  }
}
