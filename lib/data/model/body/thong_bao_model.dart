class ThongBaoModel {
  String? doiTuong;
  String? idDonDichVu;
  String? idDuAnKhachHang;
  String? idTinTuc;
  String? idTuyenDung;
  String? tieuDe;
  String? noiDung;
  String? hinhDaiDien;
  String? idDuAnNhanVien;

  ThongBaoModel({
      this.doiTuong,
      this.idDonDichVu,
      this.idDuAnKhachHang,
      this.idTinTuc,
      this.idTuyenDung,
      this.tieuDe,
      this.noiDung,
      this.hinhDaiDien,
      this.idDuAnNhanVien
      });

  ThongBaoModel.fromJson(Map<String, dynamic> json) {
    doiTuong = json['doiTuong'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idDuAnKhachHang = json['idDuAnKhachHang'].toString();
    idTinTuc = json['idTinTuc'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doiTuong'] = doiTuong;
    data['idDonDichVu'] = idDonDichVu;
    data['idDuAnKhachHang'] = idDuAnKhachHang;
    data['idTinTuc'] = idTinTuc;
    data['idTuyenDung'] = idTuyenDung;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    data['hinhDaiDien'] = hinhDaiDien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    return data;
  }
}
