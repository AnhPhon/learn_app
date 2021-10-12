class LichSuGiaoDichRequest {
  String? id;
  String? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? idDonDichVu;
  String? idTuyenDung;
  String? soTien;
  String? hinhAnhGiaoDich;
  String? trangThai;
  LichSuGiaoDichRequest({
      this.id,
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.idDonDichVu,
      this.idTuyenDung,
      this.soTien,
      this.hinhAnhGiaoDich,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  LichSuGiaoDichRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    soTien = json['soTien'].toString();
    hinhAnhGiaoDich = json['hinhAnhGiaoDich'].toString();
    trangThai = json['trangThai'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['idDonDichVu'] = idDonDichVu;
    data['idTuyenDung'] = idTuyenDung;
    data['soTien'] = soTien;
    data['hinhAnhGiaoDich'] = hinhAnhGiaoDich;
    data['trangThai'] = trangThai;
    return data;
  }
}
