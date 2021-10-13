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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang; 

    // check null taiKhoanBaoGia
    if (taiKhoanBaoGia != null) data['taiKhoanBaoGia'] = taiKhoanBaoGia; 

    // check null idTrangThaiBaoGia
    if (idTrangThaiBaoGia != null) data['idTrangThaiBaoGia'] = idTrangThaiBaoGia; 

    // check null thoiGianHoanThanh
    if (thoiGianHoanThanh != null) data['thoiGianHoanThanh'] = thoiGianHoanThanh; 

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao; 

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu; 

    // check null tienCoc
    if (tienCoc != null) data['tienCoc'] = tienCoc; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
