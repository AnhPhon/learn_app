class DangKyBaoHiemRequest {
  String? id;
  String? idTaiKhoan;
  String? idBaoHiem;
  String? file;
  String? trangThai;
  String? phi;

  DangKyBaoHiemRequest({this.id, this.idTaiKhoan, this.file, this.trangThai});

  ///
  /// From JSON
  ///
  DangKyBaoHiemRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idBaoHiem = json['idBaoHiem'].toString();
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();
    phi = json['phi'].toString();
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

    // check null idBaoHiem
    if (idBaoHiem != null) data['idBaoHiem'] = idBaoHiem;

    // check null file
    if (file != null) data['file'] = file;

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai;

    // check null phi
    if (phi != null) data['phi'] = phi;

    return data;
  }
}
