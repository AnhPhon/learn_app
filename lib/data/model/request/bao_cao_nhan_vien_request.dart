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
    id = (json['id'] == null) ? null : json['id'].toString();
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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null loai
    if (loai != null) data['loai'] = loai; 

    // check null soTuan
    if (soTuan != null) data['soTuan'] = soTuan; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
