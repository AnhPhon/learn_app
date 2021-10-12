class DanhSachThoThauBaoGiaRequest {
  String? id;
  String? idDuAnKhachHang;
  String? taiKhoanBaoGia;
  String? idTrangThaiBaoGia;
  String? thoiGianHoanThanh;
  String? giaBao;
  String? ghiChu;
  String? tienCoc;
  String? daXem;
  DanhSachThoThauBaoGiaRequest({
      this.id,
      this.idDuAnKhachHang,
      this.taiKhoanBaoGia,
      this.idTrangThaiBaoGia,
      this.thoiGianHoanThanh,
      this.giaBao,
      this.ghiChu,
      this.tienCoc,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachThoThauBaoGiaRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDuAnKhachHang = json['idDuAnKhachHang'].toString();
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    idTrangThaiBaoGia = json['idTrangThaiBaoGia'].toString();
    thoiGianHoanThanh = json['thoiGianHoanThanh'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    tienCoc = json['tienCoc'].toString();
    daXem = json['daXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDuAnKhachHang'] = idDuAnKhachHang;
    data['taiKhoanBaoGia'] = taiKhoanBaoGia;
    data['idTrangThaiBaoGia'] = idTrangThaiBaoGia;
    data['thoiGianHoanThanh'] = thoiGianHoanThanh;
    data['giaBao'] = giaBao;
    data['ghiChu'] = ghiChu;
    data['tienCoc'] = tienCoc;
    data['daXem'] = daXem;
    return data;
  }
}
