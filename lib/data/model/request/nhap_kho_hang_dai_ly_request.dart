class NhapKhoHangDaiLyRequest {
  String? id;
  String? idKhoHangDaiLy;
  String? idTaiKhoan;
  String? idSanPham;
  String? soLuong;

  NhapKhoHangDaiLyRequest(
      {this.id,
      this.idKhoHangDaiLy,
      this.idTaiKhoan,
      this.idSanPham,
      this.soLuong});

  ///
  /// From JSON
  ///
  NhapKhoHangDaiLyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idKhoHangDaiLy = json['idKhoHangDaiLy'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idSanPham = json['idSanPham'].toString();
    soLuong = json['soLuong'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idKhoHangDaiLy
    if (idKhoHangDaiLy != null) data['idKhoHangDaiLy'] = idKhoHangDaiLy;

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null idSanPham
    if (idSanPham != null) data['idSanPham'] = idSanPham;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    return data;
  }
}
