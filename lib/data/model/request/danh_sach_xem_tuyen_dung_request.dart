class DanhSachXemTuyenDungRequest {
  String? id;
  String? idTaiKhoan;
  String? idDangKyViecMoi;

  DanhSachXemTuyenDungRequest({
    this.id,
    this.idTaiKhoan,
    this.idDangKyViecMoi,
  });

  ///
  /// From JSON
  ///
  DanhSachXemTuyenDungRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idDangKyViecMoi = json['idDangKyViecMoi'].toString();
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
    if (idDangKyViecMoi != null) data['idDangKyViecMoi'] = idDangKyViecMoi;

    return data;
  }
}
