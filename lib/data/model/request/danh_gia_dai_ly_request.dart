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
    id = json['id'].toString();
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
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanDanhGia'] = taiKhoanDanhGia;
    data['diemDanhGia'] = diemDanhGia;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}
