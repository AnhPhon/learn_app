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
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanMuaHang'] = taiKhoanMuaHang;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['diaChi'] = diaChi;
    data['phiVanChuyen'] = phiVanChuyen;
    data['khuyenMai'] = khuyenMai;
    data['phiDichVu'] = phiDichVu;
    data['soTien'] = soTien;
    data['tongTien'] = tongTien;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    return data;
  }
}
