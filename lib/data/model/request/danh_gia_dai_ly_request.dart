class DanhGiaDaiLyRequest {
  String? id;
  String? idTaiKhoan;
  String? taiKhoanDanhGia;
  String? diemDanhGia;
  String? tieuDe;
  String? noiDung;

  DanhGiaDaiLyRequest({
      this.id,
      this.idTaiKhoan,
      this.taiKhoanDanhGia,
      this.diemDanhGia,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  DanhGiaDaiLyRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanDanhGia = json['taiKhoanDanhGia'].toString();
    diemDanhGia = json['diemDanhGia'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
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

    // check null taiKhoanDanhGia
    if (taiKhoanDanhGia != null) data['taiKhoanDanhGia'] = taiKhoanDanhGia; 

    // check null diemDanhGia
    if (diemDanhGia != null) data['diemDanhGia'] = diemDanhGia; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
