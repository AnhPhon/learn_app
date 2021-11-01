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
    id = (json['id'] == null) ? null : json['id'].toString();
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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null taiKhoanBaoGia
    if (taiKhoanBaoGia != null) data['taiKhoanBaoGia'] = taiKhoanBaoGia; 

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao; 

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
