class BaoCaoNhanVienModel {
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? loai;
  String? soTuan;
  String? noiDung;

  BaoCaoNhanVienModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.loai,
      this.soTuan,
      this.noiDung
      });

  BaoCaoNhanVienModel.fromJson(Map<String, dynamic> json) {
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    loai = json['loai'].toString();
    soTuan = json['soTuan'].toString();
    noiDung = json['noiDung'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['loai'] = loai;
    data['soTuan'] = soTuan;
    data['noiDung'] = noiDung;
    return data;
  }
}
