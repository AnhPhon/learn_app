class DonHangRequest {
  String? id;
  String? idTaiKhoanMuaHang;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? diaChi;
  String? phiVanChuyen;
  String? khuyenMai;
  String? phiDichVu;
  String? soTien;
  String? tongTien;
  String? soDienThoai;
  String? loaiVanChuyen;
  String? isUpdateDonHang;
  String? idTrangThaiDonHang;
  String? idTrangThaiThanhToan;
  String? idHinhThucThanhToan;

  DonHangRequest(
      {this.id,
      this.idTaiKhoanMuaHang,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.phiVanChuyen,
      this.khuyenMai,
      this.phiDichVu,
      this.soTien,
      this.tongTien,
      this.soDienThoai,
      this.loaiVanChuyen,
      this.isUpdateDonHang,
      this.idTrangThaiDonHang,
      this.idTrangThaiThanhToan,
      this.idHinhThucThanhToan});

  ///
  /// From JSON
  ///
  DonHangRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoanMuaHang = json['idTaiKhoanMuaHang'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    diaChi = json['diaChi'].toString();
    phiVanChuyen = json['phiVanChuyen'].toString();
    khuyenMai = json['khuyenMai'].toString();
    phiDichVu = json['phiDichVu'].toString();
    soTien = json['soTien'].toString();
    tongTien = json['tongTien'].toString();
    soDienThoai = json['soDienThoai'].toString();
    loaiVanChuyen = json['loaiVanChuyen'].toString();
    isUpdateDonHang = json['isUpdateDonHang'].toString();
    idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idTaiKhoanMuaHang
    if (idTaiKhoanMuaHang != null) data['idTaiKhoanMuaHang'] = idTaiKhoanMuaHang;

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

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai;

    // check null loaiVanChuyen
    if (loaiVanChuyen != null) data['loaiVanChuyen'] = loaiVanChuyen;

    // check null isUpdateDonHang
    if (isUpdateDonHang != null) data['isUpdateDonHang'] = isUpdateDonHang;

    // check null idTrangThaiDonHang
    if (idTrangThaiDonHang != null) data['idTrangThaiDonHang'] = idTrangThaiDonHang;

    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null) data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null) data['idHinhThucThanhToan'] = idHinhThucThanhToan;


    return data;
  }
}
