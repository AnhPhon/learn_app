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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon; 

    // check null yKienThoThau
    if (yKienThoThau != null) data['yKienThoThau'] = yKienThoThau; 

    // check null khachHangDanhGia
    if (khachHangDanhGia != null) data['khachHangDanhGia'] = khachHangDanhGia; 

    // check null yeuCauBaoHanh
    if (yeuCauBaoHanh != null) data['yeuCauBaoHanh'] = yeuCauBaoHanh; 

    // check null hinhAnhHuHai
    if (hinhAnhHuHai != null) data['hinhAnhHuHai'] = hinhAnhHuHai; 

    // check null noiDungYeuCauBaoHanh
    if (noiDungYeuCauBaoHanh != null) data['noiDungYeuCauBaoHanh'] = noiDungYeuCauBaoHanh; 

    // check null danhGiaBaoHanh
    if (danhGiaBaoHanh != null) data['danhGiaBaoHanh'] = danhGiaBaoHanh; 

    // check null tinhTrangThanhToan
    if (tinhTrangThanhToan != null) data['tinhTrangThanhToan'] = tinhTrangThanhToan; 


    return data;
  }
}
