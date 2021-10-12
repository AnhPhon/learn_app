class BaoCaoNhanVienRequest {
  String? id;
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? loai;
  String? soTuan;
  String? noiDung;
  BaoCaoNhanVienRequest({
      this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.loai,
      this.soTuan,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  BaoCaoNhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    loai = json['loai'].toString();
    soTuan = json['soTuan'].toString();
    noiDung = json['noiDung'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['loai'] = loai;
    data['soTuan'] = soTuan;
    data['noiDung'] = noiDung;
    return data;
  }
}
