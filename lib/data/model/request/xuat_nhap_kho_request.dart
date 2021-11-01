class XuatNhapKhoRequest {
  String? id;
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? idKhoHang;
  String? idVatTu;
  String? idDonViCungCap;
  String? soLuong;
  String? ghiChu;
  String? loai;
  String? ngayXuatNhapKhoa;

  XuatNhapKhoRequest(
      {this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.idKhoHang,
      this.idVatTu,
      this.idDonViCungCap,
      this.soLuong,
      this.loai,
      this.ngayXuatNhapKhoa,
      this.ghiChu});

  ///
  /// From JSON
  ///
  XuatNhapKhoRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    idKhoHang = json['idKhoHang'].toString();
    idVatTu = json['idVatTu'].toString();
    idDonViCungCap = json['idDonViCungCap'].toString();
    soLuong = json['soLuong'].toString();
    ghiChu = json['ghiChu'].toString();
    loai = json['loai'].toString();
    ngayXuatNhapKhoa = json['ngayXuatNhapKhoa'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien;

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien;

    // check null idKhoHang
    if (idKhoHang != null) data['idKhoHang'] = idKhoHang;

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu;

    // check null idDonViCungCap
    if (idDonViCungCap != null) data['idDonViCungCap'] = idDonViCungCap;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null loai
    if (loai != null) data['loai'] = loai;

    // check null ngay xuat nhap kho
    if (ngayXuatNhapKhoa != null) data['ngayXuatNhapKhoa'] = ngayXuatNhapKhoa;

    return data;
  }
}
