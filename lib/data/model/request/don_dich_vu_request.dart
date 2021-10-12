class DonDichVuRequest {
  String? id;
  String? idTaiKhoan;
  String? idNhomDichVu;
  String? tieuDe;
  String? moTa;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? hinhAnhBanKhoiLuong;
  String? hinhAnhBanVe;
  String? idTrangThaiDonHang;
  String? idHinhThucThanhToan;
  String? idTrangThaiThanhToan;
  String? idThoiGianLamViec;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? giaTriKhachDeXuat;
  String? hinhAnhChiTiet;
  String? moTaChiTiet;
  String? file;
  String? soLuongYeuCau;
  String? soNgay;
  String? diaDiemLamViec;
  String? idBangGiaDonHang;
  String? gioiTinh;
  String? idThongSoKyThuat;
  String? diaDiemBocHang;
  String? diaDiemTraHang;
  String? cuLyVanChuyen;
  String? beRongDiemNhan;
  String? beRongDiemTra;
  String? hinhAnhBaoGia;
  String? phiDichVu;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? taiKhoanNhanDon;
  String? tienCoc;
  DonDichVuRequest({
      this.id,
      this.idTaiKhoan,
      this.idNhomDichVu,
      this.tieuDe,
      this.moTa,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hinhAnhBanKhoiLuong,
      this.hinhAnhBanVe,
      this.idTrangThaiDonHang,
      this.idHinhThucThanhToan,
      this.idTrangThaiThanhToan,
      this.idThoiGianLamViec,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.giaTriKhachDeXuat,
      this.hinhAnhChiTiet,
      this.moTaChiTiet,
      this.file,
      this.soLuongYeuCau,
      this.soNgay,
      this.diaDiemLamViec,
      this.idBangGiaDonHang,
      this.gioiTinh,
      this.idThongSoKyThuat,
      this.diaDiemBocHang,
      this.diaDiemTraHang,
      this.cuLyVanChuyen,
      this.beRongDiemNhan,
      this.beRongDiemTra,
      this.hinhAnhBaoGia,
      this.phiDichVu,
      this.khuyenMai,
      this.soTien,
      this.tongDon,
      this.taiKhoanNhanDon,
      this.tienCoc});
  
  ///
  /// From JSON
  ///
  DonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    tieuDe = json['tieuDe'].toString();
    moTa = json['moTa'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    hinhAnhBanKhoiLuong = json['hinhAnhBanKhoiLuong'].toString();
    hinhAnhBanVe = json['hinhAnhBanVe'].toString();
    idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    idThoiGianLamViec = json['idThoiGianLamViec'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();
    hinhAnhChiTiet = json['hinhAnhChiTiet'].toString();
    moTaChiTiet = json['moTaChiTiet'].toString();
    file = json['file'].toString();
    soLuongYeuCau = json['soLuongYeuCau'].toString();
    soNgay = json['soNgay'].toString();
    diaDiemLamViec = json['diaDiemLamViec'].toString();
    idBangGiaDonHang = json['idBangGiaDonHang'].toString();
    gioiTinh = json['gioiTinh'].toString();
    idThongSoKyThuat = json['idThongSoKyThuat'].toString();
    diaDiemBocHang = json['diaDiemBocHang'].toString();
    diaDiemTraHang = json['diaDiemTraHang'].toString();
    cuLyVanChuyen = json['cuLyVanChuyen'].toString();
    beRongDiemNhan = json['beRongDiemNhan'].toString();
    beRongDiemTra = json['beRongDiemTra'].toString();
    hinhAnhBaoGia = json['hinhAnhBaoGia'].toString();
    phiDichVu = json['phiDichVu'].toString();
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    tienCoc = json['tienCoc'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['idNhomDichVu'] = idNhomDichVu;
    data['tieuDe'] = tieuDe;
    data['moTa'] = moTa;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['hinhAnhBanKhoiLuong'] = hinhAnhBanKhoiLuong;
    data['hinhAnhBanVe'] = hinhAnhBanVe;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;
    data['idThoiGianLamViec'] = idThoiGianLamViec;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['giaTriKhachDeXuat'] = giaTriKhachDeXuat;
    data['hinhAnhChiTiet'] = hinhAnhChiTiet;
    data['moTaChiTiet'] = moTaChiTiet;
    data['file'] = file;
    data['soLuongYeuCau'] = soLuongYeuCau;
    data['soNgay'] = soNgay;
    data['diaDiemLamViec'] = diaDiemLamViec;
    data['idBangGiaDonHang'] = idBangGiaDonHang;
    data['gioiTinh'] = gioiTinh;
    data['idThongSoKyThuat'] = idThongSoKyThuat;
    data['diaDiemBocHang'] = diaDiemBocHang;
    data['diaDiemTraHang'] = diaDiemTraHang;
    data['cuLyVanChuyen'] = cuLyVanChuyen;
    data['beRongDiemNhan'] = beRongDiemNhan;
    data['beRongDiemTra'] = beRongDiemTra;
    data['hinhAnhBaoGia'] = hinhAnhBaoGia;
    data['phiDichVu'] = phiDichVu;
    data['khuyenMai'] = khuyenMai;
    data['soTien'] = soTien;
    data['tongDon'] = tongDon;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['tienCoc'] = tienCoc;
    return data;
  }
}
