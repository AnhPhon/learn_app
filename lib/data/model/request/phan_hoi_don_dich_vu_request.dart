class PhanHoiDonDichVuRequest {
  String? id;
  String? idDonDichVu;
  String? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? yKienThoThau;
  String? khachHangDanhGia;
  String? yeuCauBaoHanh;
  String? hinhAnhHuHai;
  String? noiDungYeuCauBaoHanh;
  String? danhGiaBaoHanh;
  String? tinhTrangThanhToan;
  PhanHoiDonDichVuRequest({
      this.id,
      this.idDonDichVu,
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.yKienThoThau,
      this.khachHangDanhGia,
      this.yeuCauBaoHanh,
      this.hinhAnhHuHai,
      this.noiDungYeuCauBaoHanh,
      this.danhGiaBaoHanh,
      this.tinhTrangThanhToan});
  
  ///
  /// From JSON
  ///
  PhanHoiDonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    yKienThoThau = json['yKienThoThau'].toString();
    khachHangDanhGia = json['khachHangDanhGia'].toString();
    yeuCauBaoHanh = json['yeuCauBaoHanh'].toString();
    hinhAnhHuHai = json['hinhAnhHuHai'].toString();
    noiDungYeuCauBaoHanh = json['noiDungYeuCauBaoHanh'].toString();
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    tinhTrangThanhToan = json['tinhTrangThanhToan'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDonDichVu'] = idDonDichVu;
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['yKienThoThau'] = yKienThoThau;
    data['khachHangDanhGia'] = khachHangDanhGia;
    data['yeuCauBaoHanh'] = yeuCauBaoHanh;
    data['hinhAnhHuHai'] = hinhAnhHuHai;
    data['noiDungYeuCauBaoHanh'] = noiDungYeuCauBaoHanh;
    data['danhGiaBaoHanh'] = danhGiaBaoHanh;
    data['tinhTrangThanhToan'] = tinhTrangThanhToan;
    return data;
  }
}
