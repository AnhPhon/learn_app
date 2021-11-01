class DangKyViecMoiRequest {
  String? id;
  String? idTaiKhoan;
  String? tieuDe;
  String? tenUngVien;
  String? gioiTinh;
  String? ngaySinh;
  String? email;
  String? diaChi;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? honNhan;
  String? idLoaiNhanVien;
  String? mucTieuNgheNghiep;
  String? idBangBangCap;
  String? chucVuHienTai;
  String? chucVuMongMuon;
  String? idSoNamKinhNghiem;
  String? noiLamViec;
  String? mucLuongDeXuat;
  String? idKeKhaiKinhNghiem;
  String? anhHoSoXinViec;
  String? fileHoSoXinViec;
  String? kyNangSoTruong;
  String? idNgoaiNgu;
  String? idTinHoc;
  String? idHinhThucLamViec;

  DangKyViecMoiRequest(
      {this.id,
      this.idTaiKhoan,
      this.tieuDe,
      this.tenUngVien,
      this.gioiTinh,
      this.ngaySinh,
      this.email,
      this.diaChi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.honNhan,
      this.idLoaiNhanVien,
      this.mucTieuNgheNghiep,
      this.idBangBangCap,
      this.chucVuHienTai,
      this.chucVuMongMuon,
      this.idSoNamKinhNghiem,
      this.noiLamViec,
      this.mucLuongDeXuat,
      this.idKeKhaiKinhNghiem,
      this.anhHoSoXinViec,
      this.fileHoSoXinViec,
      this.kyNangSoTruong,
      this.idNgoaiNgu,
      this.idTinHoc,
      this.idHinhThucLamViec});

  ///
  /// From JSON
  ///
  DangKyViecMoiRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    tieuDe = json['tieuDe'].toString();
    tenUngVien = json['tenUngVien'].toString();
    gioiTinh = json['gioiTinh'].toString();
    ngaySinh = json['ngaySinh'].toString();
    email = json['email'].toString();
    diaChi = json['diaChi'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    honNhan = json['honNhan'].toString();
    idLoaiNhanVien = json['idLoaiNhanVien'].toString();
    mucTieuNgheNghiep = json['mucTieuNgheNghiep'].toString();
    idBangBangCap = json['idBangBangCap'].toString();
    chucVuHienTai = json['chucVuHienTai'].toString();
    chucVuMongMuon = json['chucVuMongMuon'].toString();
    idSoNamKinhNghiem = json['idSoNamKinhNghiem'].toString();
    noiLamViec = json['noiLamViec'].toString();
    mucLuongDeXuat = json['mucLuongDeXuat'].toString();
    idKeKhaiKinhNghiem = json['idKeKhaiKinhNghiem'].toString();
    anhHoSoXinViec = json['anhHoSoXinViec'].toString();
    fileHoSoXinViec = json['fileHoSoXinViec'].toString();
    kyNangSoTruong = json['kyNangSoTruong'].toString();
    idNgoaiNgu = json['idNgoaiNgu'].toString();
    idTinHoc = json['idTinHoc'].toString();
    idHinhThucLamViec = json['idHinhThucLamViec'].toString();
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

    // check null tenUngVien
    if (tenUngVien != null) data['tenUngVien'] = tenUngVien;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null ngaySinh
    if (ngaySinh != null) data['ngaySinh'] = ngaySinh;

    // check null email
    if (email != null) data['email'] = email;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null honNhan
    if (honNhan != null) data['honNhan'] = honNhan;

    // check null idLoaiNhanVien
    if (idLoaiNhanVien != null) data['idLoaiNhanVien'] = idLoaiNhanVien;

    // check null mucTieuNgheNghiep
    if (mucTieuNgheNghiep != null)
      data['mucTieuNgheNghiep'] = mucTieuNgheNghiep;

    // check null idBangBangCap
    if (idBangBangCap != null) data['idBangBangCap'] = idBangBangCap;

    // check null chucVuHienTai
    if (chucVuHienTai != null) data['chucVuHienTai'] = chucVuHienTai;

    // check null chucVuMongMuon
    if (chucVuMongMuon != null) data['chucVuMongMuon'] = chucVuMongMuon;

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null)
      data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;

    // check null noiLamViec
    if (noiLamViec != null) data['noiLamViec'] = noiLamViec;

    // check null mucLuongDeXuat
    if (mucLuongDeXuat != null) data['mucLuongDeXuat'] = mucLuongDeXuat;

    // check null idKeKhaiKinhNghiem
    if (idKeKhaiKinhNghiem != null)
      data['idKeKhaiKinhNghiem'] = idKeKhaiKinhNghiem;

    // check null anhHoSoXinViec
    if (anhHoSoXinViec != null) data['anhHoSoXinViec'] = anhHoSoXinViec;

    // check null fileHoSoXinViec
    if (fileHoSoXinViec != null) data['fileHoSoXinViec'] = fileHoSoXinViec;

    // check null kyNangSoTruong
    if (kyNangSoTruong != null) data['kyNangSoTruong'] = kyNangSoTruong;

    // check null idNgoaiNgu
    if (idNgoaiNgu != null) data['idNgoaiNgu'] = idNgoaiNgu;

    // check null idTinHoc
    if (idTinHoc != null) data['idTinHoc'] = idTinHoc;

    // check null idHinhThucLamViec
    if (idHinhThucLamViec != null)
      data['idHinhThucLamViec'] = idHinhThucLamViec;

    return data;
  }
}
