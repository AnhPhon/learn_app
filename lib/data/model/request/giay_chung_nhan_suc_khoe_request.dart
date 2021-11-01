class GiayChungNhanSucKhoeRequest {
  String? id;
  String? idTaiKhoan;
  String? file;
  String? trangThai;

  GiayChungNhanSucKhoeRequest({
      this.id,
      this.idTaiKhoan,
      this.file,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  GiayChungNhanSucKhoeRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    file = json['file'].toString();
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

    // check null file
    if (file != null) data['file'] = file; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
