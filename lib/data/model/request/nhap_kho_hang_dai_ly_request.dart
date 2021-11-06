class NhapKhoHangDaiLyRequest {
  String? id;
  String? idKhoHangDaiLy;
  String? idTaiKhoan;
  String? idSanPham;
  String? soLuong;
  String? tinhTrangSanPham;
  String? loai;

  NhapKhoHangDaiLyRequest(
      {this.id,
      this.idKhoHangDaiLy,
      this.idTaiKhoan,
      this.idSanPham,
      this.soLuong,
      this.tinhTrangSanPham,
      this.loai,
      });

  ///
  /// From JSON
  ///
  NhapKhoHangDaiLyRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idKhoHangDaiLy = json['idKhoHangDaiLy'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idSanPham = json['idSanPham'].toString();
    soLuong = json['soLuong'].toString();
    tinhTrangSanPham = json['tinhTrangSanPham'].toString();
    loai = json['loai'].toString();
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

    // check null tinhTrangSanPham
    if (tinhTrangSanPham != null) data['tinhTrangSanPham'] = tinhTrangSanPham;

    // check null loai
    if (loai != null) data['loai'] = loai;

    return data;
  }
}
