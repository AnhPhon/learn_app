class DanhSachBaoGiaDonDichVuRequest {
  String? id;
  String? idDonDichVu;
  String? taiKhoanBaoGia;
  String? giaBao;
  String? ghiChu;
  String? file;
  String? daXem;
  DanhSachBaoGiaDonDichVuRequest({
      this.id,
      this.idDonDichVu,
      this.taiKhoanBaoGia,
      this.giaBao,
      this.ghiChu,
      this.file,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    file = json['file'].toString();
    daXem = json['daXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDonDichVu'] = idDonDichVu;
    data['taiKhoanBaoGia'] = taiKhoanBaoGia;
    data['giaBao'] = giaBao;
    data['ghiChu'] = ghiChu;
    data['file'] = file;
    data['daXem'] = daXem;
    return data;
  }
}
