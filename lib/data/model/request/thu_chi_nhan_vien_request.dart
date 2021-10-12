class ThuChiNhanVienRequest {
  String? id;
  String? idNhanVien;
  String? loai;
  String? tieuDe;
  String? soTien;
  String? noiDung;
  ThuChiNhanVienRequest({
      this.id,
      this.idNhanVien,
      this.loai,
      this.tieuDe,
      this.soTien,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  ThuChiNhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNhanVien'] = idNhanVien;
    data['loai'] = loai;
    data['tieuDe'] = tieuDe;
    data['soTien'] = soTien;
    data['noiDung'] = noiDung;
    return data;
  }
}
