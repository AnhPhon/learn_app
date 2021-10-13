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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null hinhAnhGiaoDich
    if (hinhAnhGiaoDich != null) data['hinhAnhGiaoDich'] = hinhAnhGiaoDich; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
