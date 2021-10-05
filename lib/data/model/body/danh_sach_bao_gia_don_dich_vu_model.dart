class DanhSachBaoGiaDonDichVuModel {
  String? idDonDichVu;
  String? taiKhoanBaoGia;
  String? giaBao;
  String? ghiChu;
  String? file;
  String? daXem;

  DanhSachBaoGiaDonDichVuModel({
      this.idDonDichVu,
      this.taiKhoanBaoGia,
      this.giaBao,
      this.ghiChu,
      this.file,
      this.daXem
      });

  DanhSachBaoGiaDonDichVuModel.fromJson(Map<String, dynamic> json) {
    idDonDichVu = json['idDonDichVu'].toString();
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    file = json['file'].toString();
    daXem = json['daXem'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonDichVu'] = idDonDichVu;
    data['taiKhoanBaoGia'] = taiKhoanBaoGia;
    data['giaBao'] = giaBao;
    data['ghiChu'] = ghiChu;
    data['file'] = file;
    data['daXem'] = daXem;
    return data;
  }
}
