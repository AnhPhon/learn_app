class DanhGiaDaiLyModel {
  String? idTaiKhoan;
  String? taiKhoanDanhGia;
  String? diemDanhGia;
  String? tieuDe;
  String? noiDung;

  DanhGiaDaiLyModel({
      this.idTaiKhoan,
      this.taiKhoanDanhGia,
      this.diemDanhGia,
      this.tieuDe,
      this.noiDung
      });

  DanhGiaDaiLyModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanDanhGia = json['taiKhoanDanhGia'].toString();
    diemDanhGia = json['diemDanhGia'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanDanhGia'] = taiKhoanDanhGia;
    data['diemDanhGia'] = diemDanhGia;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    return data;
  }
}
