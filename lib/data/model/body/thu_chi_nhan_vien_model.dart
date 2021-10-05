class ThuChiNhanVienModel {
  String? idNhanVien;
  String? loai;
  String? tieuDe;
  String? soTien;
  String? noiDung;

  ThuChiNhanVienModel({
      this.idNhanVien,
      this.loai,
      this.tieuDe,
      this.soTien,
      this.noiDung
      });

  ThuChiNhanVienModel.fromJson(Map<String, dynamic> json) {
    idNhanVien = json['idNhanVien'].toString();
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['loai'] = loai;
    data['tieuDe'] = tieuDe;
    data['soTien'] = soTien;
    data['noiDung'] = noiDung;
    return data;
  }
}
