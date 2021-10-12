class CongViecNhanVienRequest {
  String? id;
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? trangThai;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? ngayThucTe;
  CongViecNhanVienRequest({
      this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.trangThai,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.ngayThucTe});
  
  ///
  /// From JSON
  ///
  CongViecNhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    trangThai = json['trangThai'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    ngayThucTe = json['ngayThucTe'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['trangThai'] = trangThai;
    data['tieuDe'] = tieuDe;
    data['tomTat'] = tomTat;
    data['noiDung'] = noiDung;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['ngayThucTe'] = ngayThucTe;
    return data;
  }
}
