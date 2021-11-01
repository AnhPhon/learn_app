class LichSuViTienRequest {
  String? id;
  String? idTaiKhoan;
  String? idViTien;
  String? loaiGiaoDich;
  String? soTien;
  String? noiDung;
  String? trangThai;
  String? hinhAnhHoaDon;

  LichSuViTienRequest({
      this.id,
      this.idTaiKhoan,
      this.idViTien,
      this.loaiGiaoDich,
      this.soTien,
      this.noiDung,
      this.trangThai,
      this.hinhAnhHoaDon,
      });
  
  ///
  /// From JSON
  ///
  LichSuViTienRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idViTien = json['idViTien'].toString();
    loaiGiaoDich = json['loaiGiaoDich'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();
    trangThai = json['trangThai'].toString();
    hinhAnhHoaDon = json['hinhAnhHoaDon'].toString();
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

    // check null idViTien
    if (idViTien != null) data['idViTien'] = idViTien; 

    // check null loaiGiaoDich
    if (loaiGiaoDich != null) data['loaiGiaoDich'] = loaiGiaoDich; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 

    // check null hinhAnhHoaDon
    if (hinhAnhHoaDon != null) data['hinhAnhHoaDon'] = hinhAnhHoaDon; 


    return data;
  }
}
