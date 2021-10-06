class XuatNhapKhoModel {
  String? idNhanVien;
  String? idDuAnNhanVien;
  String? idKhoHang;
  String? idVatTu;
  String? idDonViCungCap;
  String? soLuong;
  String? ghiChu;

  XuatNhapKhoModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.idKhoHang,
      this.idVatTu,
      this.idDonViCungCap,
      this.soLuong,
      this.ghiChu
      });

  XuatNhapKhoModel.fromJson(Map<String, dynamic> json) {
    idNhanVien = json['idNhanVien'].toString();
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    idKhoHang = json['idKhoHang'].toString();
    idVatTu = json['idVatTu'].toString();
    idDonViCungCap = json['idDonViCungCap'].toString();
    soLuong = json['soLuong'].toString();
    ghiChu = json['ghiChu'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['idKhoHang'] = idKhoHang;
    data['idVatTu'] = idVatTu;
    data['idDonViCungCap'] = idDonViCungCap;
    data['soLuong'] = soLuong;
    data['ghiChu'] = ghiChu;
    return data;
  }
}
