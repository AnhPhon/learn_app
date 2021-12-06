class PhanHoiDonDichVuRequest {
  String? id;
  String? idDonDichVu;
  String? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? idTaiKhoanNhanDon;
  String? yKienThoThau;
  String? yKienThoThauViecDaLam;
  String? khachHangDanhGia;
  String? khachHangDanhGiaViecDaLam;
  String? yeuCauBaoHanh;
  String? hinhAnhHuHai;
  String? noiDungYeuCauBaoHanh;
  String? danhGiaBaoHanh;
  String? tinhTrangThanhToan;
  String? daXem;
  List<String>? idYeuCauBaoHanhs;

  PhanHoiDonDichVuRequest({
    this.id,
    this.idDonDichVu,
    this.idTaiKhoan,
    this.taiKhoanNhanDon,
    this.idTaiKhoanNhanDon,
    this.yKienThoThau,
    this.yKienThoThauViecDaLam,
    this.khachHangDanhGia,
    this.khachHangDanhGiaViecDaLam,
    this.yeuCauBaoHanh,
    this.hinhAnhHuHai,
    this.noiDungYeuCauBaoHanh,
    this.danhGiaBaoHanh,
    this.tinhTrangThanhToan,
    this.daXem,
    this.idYeuCauBaoHanhs,
  });

  ///
  /// From JSON
  ///
  PhanHoiDonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idDonDichVu = json['idDonDichVu'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    idTaiKhoanNhanDon = json['idTaiKhoanNhanDon'].toString();
    yKienThoThau = json['yKienThoThau'].toString();
    yKienThoThauViecDaLam = json['yKienThoThauViecDaLam'].toString();
    khachHangDanhGia = json['khachHangDanhGia'].toString();
    khachHangDanhGiaViecDaLam = json['khachHangDanhGiaViecDaLam'].toString();
    yeuCauBaoHanh = json['yeuCauBaoHanh'].toString();
    hinhAnhHuHai = json['hinhAnhHuHai'].toString();
    noiDungYeuCauBaoHanh = json['noiDungYeuCauBaoHanh'].toString();
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    tinhTrangThanhToan = json['tinhTrangThanhToan'].toString();
    daXem = json['daXem'].toString();
    if(json['idYeuCauBaoHanhs'] != null) idYeuCauBaoHanhs = (json['idYeuCauBaoHanhs'] as List<dynamic>).map((e) => e.toString()).toList();
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

    // check null idTaiKhoanNhanDon
    if (idTaiKhoanNhanDon != null) data['idTaiKhoanNhanDon'] = idTaiKhoanNhanDon;

    // check null yKienThoThau
    if (yKienThoThau != null) data['yKienThoThau'] = yKienThoThau;

    // check null yKienThoThauViecDaLam
    if (yKienThoThauViecDaLam != null) data['yKienThoThauViecDaLam'] = yKienThoThauViecDaLam;

    // check null khachHangDanhGia
    if (khachHangDanhGia != null) data['khachHangDanhGia'] = khachHangDanhGia;

    // check null khachHangDanhGiaViecDaLam
    if (khachHangDanhGiaViecDaLam != null) data['khachHangDanhGiaViecDaLam'] = khachHangDanhGiaViecDaLam;

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

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null idYeuCauBaoHanhs
    if (idYeuCauBaoHanhs != null) data['idYeuCauBaoHanhs'] = idYeuCauBaoHanhs;

    return data;
  }
}
