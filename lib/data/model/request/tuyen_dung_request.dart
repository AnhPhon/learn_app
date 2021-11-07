class TuyenDungRequest {
  String? id;
  String? idTaiKhoan;
  String? tieuDe;
  String? congTy;
  String? diaChi;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? gioiTinh;
  String? soLuong;
  String? idHinhThucLamViec;
  String? idTrinhDoHocVan;
  String? idChuyenNganhChinh;
  String? idSoNamKinhNghiem;
  String? idMucLuongDuKien;
  String? idNoiLamViec;
  String? idThoiGianLamViec;
  String? moTaCongViec;
  String? yeuCauCongViec;
  String? quyenLoi;
  String? uuTien;
  String? hanNopHoSo;
  String? hoTenLienHe;
  String? soDienThoaiLienHe;
  String? diaChiLienHe;
  String? emailLienHe;
  String? idBangGiaDangTin;
  String? idBangGiaLocHoSo;
  String? idHinhThucThanhToan;
  String? idTrangThaiTuyenDung;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? thoiGianThuViec;
  List<dynamic>? idChuyenNganhPhus;
  String? phiDichVu;
  String? tienCoc;
  String? idTrangThaiThanhToan;
  String? hinhAnhDaiDien;
  String? loaiTin;

  TuyenDungRequest(
      {this.id,
      this.idTaiKhoan,
      this.tieuDe,
      this.congTy,
      this.diaChi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.gioiTinh,
      this.soLuong,
      this.idHinhThucLamViec,
      this.idTrinhDoHocVan,
      this.idChuyenNganhChinh,
      this.idSoNamKinhNghiem,
      this.idMucLuongDuKien,
      this.idNoiLamViec,
      this.idThoiGianLamViec,
      this.moTaCongViec,
      this.yeuCauCongViec,
      this.quyenLoi,
      this.uuTien,
      this.hanNopHoSo,
      this.hoTenLienHe,
      this.soDienThoaiLienHe,
      this.diaChiLienHe,
      this.emailLienHe,
      this.idBangGiaDangTin,
      this.idBangGiaLocHoSo,
      this.idHinhThucThanhToan,
      this.idTrangThaiTuyenDung,
      this.khuyenMai,
      this.soTien,
      this.tongDon,
      this.thoiGianThuViec,
      this.idChuyenNganhPhus,
      this.phiDichVu,
      this.tienCoc,
      this.idTrangThaiThanhToan,
      this.hinhAnhDaiDien,
      this.loaiTin});

  ///
  /// From JSON
  ///
  TuyenDungRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
    congTy = json['congTy'].toString();
    diaChi = json['diaChi'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    gioiTinh = json['gioiTinh'].toString();
    soLuong = json['soLuong'].toString();
    idHinhThucLamViec = json['idHinhThucLamViec'].toString();
    idTrinhDoHocVan = json['idTrinhDoHocVan'].toString();
    idChuyenNganhChinh = json['idChuyenNganhChinh'].toString();
    idSoNamKinhNghiem = json['idSoNamKinhNghiem'].toString();
    idMucLuongDuKien = json['idMucLuongDuKien'].toString();
    idNoiLamViec = json['idNoiLamViec'].toString();
    idThoiGianLamViec = json['idThoiGianLamViec'].toString();
    moTaCongViec = json['moTaCongViec'].toString();
    yeuCauCongViec = json['yeuCauCongViec'].toString();
    quyenLoi = json['quyenLoi'].toString();
    uuTien = json['uuTien'].toString();
    hanNopHoSo = json['hanNopHoSo'].toString();
    hoTenLienHe = json['hoTenLienHe'].toString();
    soDienThoaiLienHe = json['soDienThoaiLienHe'].toString();
    diaChiLienHe = json['diaChiLienHe'].toString();
    emailLienHe = json['emailLienHe'].toString();
    idBangGiaDangTin = json['idBangGiaDangTin'].toString();
    idBangGiaLocHoSo = json['idBangGiaLocHoSo'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    idTrangThaiTuyenDung = json['idTrangThaiTuyenDung'].toString();
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
    thoiGianThuViec = json['thoiGianThuViec'].toString();
    idChuyenNganhPhus = json['idChuyenNganhPhus'] as List<dynamic>;
    phiDichVu = json['phiDichVu'].toString();
    tienCoc = json['tienCoc'].toString();
    idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    loaiTin = json['loaiTin'].toString();
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

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null congTy
    if (congTy != null) data['congTy'] = congTy;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null idHinhThucLamViec
    if (idHinhThucLamViec != null)
      data['idHinhThucLamViec'] = idHinhThucLamViec;

    // check null idTrinhDoHocVan
    if (idTrinhDoHocVan != null) data['idTrinhDoHocVan'] = idTrinhDoHocVan;

    // check null idChuyenNganhChinh
    if (idChuyenNganhChinh != null)
      data['idChuyenNganhChinh'] = idChuyenNganhChinh;

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null)
      data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;

    // check null idMucLuongDuKien
    if (idMucLuongDuKien != null) data['idMucLuongDuKien'] = idMucLuongDuKien;

    // check null idNoiLamViec
    if (idNoiLamViec != null) data['idNoiLamViec'] = idNoiLamViec;

    // check null idThoiGianLamViec
    if (idThoiGianLamViec != null)
      data['idThoiGianLamViec'] = idThoiGianLamViec;

    // check null moTaCongViec
    if (moTaCongViec != null) data['moTaCongViec'] = moTaCongViec;

    // check null yeuCauCongViec
    if (yeuCauCongViec != null) data['yeuCauCongViec'] = yeuCauCongViec;

    // check null quyenLoi
    if (quyenLoi != null) data['quyenLoi'] = quyenLoi;

    // check null uuTien
    if (uuTien != null) data['uuTien'] = uuTien;

    // check null hanNopHoSo
    if (hanNopHoSo != null) data['hanNopHoSo'] = hanNopHoSo;

    // check null hoTenLienHe
    if (hoTenLienHe != null) data['hoTenLienHe'] = hoTenLienHe;

    // check null soDienThoaiLienHe
    if (soDienThoaiLienHe != null)
      data['soDienThoaiLienHe'] = soDienThoaiLienHe;

    // check null diaChiLienHe
    if (diaChiLienHe != null) data['diaChiLienHe'] = diaChiLienHe;

    // check null emailLienHe
    if (emailLienHe != null) data['emailLienHe'] = emailLienHe;

    // check null idBangGiaDangTin
    if (idBangGiaDangTin != null) data['idBangGiaDangTin'] = idBangGiaDangTin;

    // check null idBangGiaLocHoSo
    if (idBangGiaLocHoSo != null) data['idBangGiaLocHoSo'] = idBangGiaLocHoSo;

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null)
      data['idHinhThucThanhToan'] = idHinhThucThanhToan;

    // check null idTrangThaiTuyenDung
    if (idTrangThaiTuyenDung != null)
      data['idTrangThaiTuyenDung'] = idTrangThaiTuyenDung;

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai;

    // check null soTien
    if (soTien != null) data['soTien'] = soTien;

    // check null tongDon
    if (tongDon != null) data['tongDon'] = tongDon;

    // check null thoiGianThuViec
    if (thoiGianThuViec != null) data['thoiGianThuViec'] = thoiGianThuViec;

    // check null idChuyenNganhPhus
    if (idChuyenNganhPhus != null)
      data['idChuyenNganhPhus'] = idChuyenNganhPhus;
    // check null idChuyenNganhPhus
    if (phiDichVu != null) data['phiDichVu'] = phiDichVu;
    // check null tienCoc
    if (tienCoc != null) data['tienCoc'] = tienCoc;
    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null)
      data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;
    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien;
    if (loaiTin != null) data['loaiTin'] = loaiTin;

    return data;
  }
}
