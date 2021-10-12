class DonHangRequest {
  String? id;
  String? idTaiKhoan;
  String? taiKhoanMuaHang;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? diaChi;
  String? phiVanChuyen;
  String? khuyenMai;
  String? phiDichVu;
  String? soTien;
  String? tongTien;
  String? idTrangThaiDonHang;
  String? idHinhThucThanhToan;

  DonHangRequest({
      this.id,
      this.idTaiKhoan,
      this.taiKhoanMuaHang,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.phiVanChuyen,
      this.khuyenMai,
      this.phiDichVu,
      this.soTien,
      this.tongTien,
      this.idTrangThaiDonHang,
      this.idHinhThucThanhToan});
  
  ///
  /// From JSON
  ///
  DonHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanMuaHang = json['taiKhoanMuaHang'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    diaChi = json['diaChi'].toString();
    phiVanChuyen = json['phiVanChuyen'].toString();
    khuyenMai = json['khuyenMai'].toString();
    phiDichVu = json['phiDichVu'].toString();
    soTien = json['soTien'].toString();
    tongTien = json['tongTien'].toString();
    idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanMuaHang
    if (taiKhoanMuaHang != null) data['taiKhoanMuaHang'] = taiKhoanMuaHang; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null phiVanChuyen
    if (phiVanChuyen != null) data['phiVanChuyen'] = phiVanChuyen; 

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai; 

    // check null phiDichVu
    if (phiDichVu != null) data['phiDichVu'] = phiDichVu; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null tongTien
    if (tongTien != null) data['tongTien'] = tongTien; 

    // check null idTrangThaiDonHang
    if (idTrangThaiDonHang != null) data['idTrangThaiDonHang'] = idTrangThaiDonHang; 

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null) data['idHinhThucThanhToan'] = idHinhThucThanhToan; 


    return data;
  }
}
