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

  String? chucVuHienTai;
  String? chucVuMongMuon;
  String? idSoNamKinhNghiem;
  List<dynamic>? noiLamViec;
  String? mucLuongDeXuat;

  String? kyNangSoTruong;

  String? idHinhThucLamViec;
  String? idNhomDichVu;
  String? idLoaiCongViec;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? soLuong;

  String? tieuDeSearch;
  List<dynamic>? idDiaDiemDangKyLamViecs;
  List<dynamic>? anhHoSoXinViecs;
  List<dynamic>? idNgoaiNgu;
  List<dynamic>? idBangBangCap;
  List<dynamic>? idKeKhaiKinhNghiem;
  String? idTinHoc;
  List<dynamic>? idNganhNgheMongMuons;

  String? fileHoSoXinViec;

  //Bổ sung
  String? phanMemHoTro;
  String? soThichTrinhDo;
  String? soThichKyNang;
  String? soTichTinhCach;
  String? idMucLuongDuKien;

  //Tham khảo
  String? nguoiThamKhao;
  String? chucDanh;
  String? congTy;
  String? soDienThoai;
  String? emailThamKhao;

  DangKyViecMoiRequest({
    this.id,
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
    this.fileHoSoXinViec,
    this.kyNangSoTruong,
    this.idNgoaiNgu,
    this.idTinHoc,
    this.idHinhThucLamViec,
    this.idNhomDichVu,
    this.idLoaiCongViec,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.soLuong,
    this.idDiaDiemDangKyLamViecs,
    this.tieuDeSearch,
    this.anhHoSoXinViecs,
    this.idNganhNgheMongMuons,

    // Bổ sung
    this.phanMemHoTro,
    this.soThichTrinhDo,
    this.soThichKyNang,
    this.soTichTinhCach,
    this.idMucLuongDuKien,

    //Tham khảo
    this.nguoiThamKhao,
    this.chucDanh,
    this.congTy,
    this.soDienThoai,
    this.emailThamKhao,
  });

  ///
  /// From JSON
  ///
  DangKyViecMoiRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
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

    chucVuHienTai = json['chucVuHienTai'].toString();
    chucVuMongMuon = json['chucVuMongMuon'].toString();
    idSoNamKinhNghiem = json['idSoNamKinhNghiem'].toString();

    if (json['noiLamViecs'] != null) {
      noiLamViec = json['noiLamViecs'] as List<dynamic>;
    }

    mucLuongDeXuat = json['mucLuongDeXuat'].toString();

    kyNangSoTruong = json['kyNangSoTruong'].toString();

    idHinhThucLamViec = json['idHinhThucLamViec'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    idLoaiCongViec = json['idLoaiCongViec'].toString();

    // Bổ sung
    phanMemHoTro = json['phanMemHoTro'].toString();
    soThichTrinhDo = json['soThichTrinhDo'].toString();
    soThichKyNang = json['soThichKyNang'].toString();
    soTichTinhCach = json['soTichTinhCach'].toString();
    idMucLuongDuKien = json['idMucLuongDuKien'].toString();

    //Tham khảo
    nguoiThamKhao = json['nguoiThamKhao'].toString();
    chucDanh = json['chucDanh'].toString();
    congTy = json['congTy'].toString();
    soDienThoai = json['soDienThoai'].toString();
    emailThamKhao = json['emailThamKhao'].toString();

    if (json['tieuDeSearch'] != null) {
      tieuDeSearch = json['tieuDeSearch'].toString();
    }

    if (json['thoiGianBatDau'] != null) {
      thoiGianBatDau = json['thoiGianBatDau'].toString();
    }

    if (json['thoiGianKetThuc'] != null) {
      thoiGianKetThuc = json['thoiGianKetThuc'].toString();
    }

    if (json['soLuong'] != null) {
      soLuong = json['soLuong'].toString();
    }

    if (json['idDiaDiemDangKyLamViecs'] != null) {
      idDiaDiemDangKyLamViecs =
          json['idDiaDiemDangKyLamViecs'] as List<dynamic>;
    }

    if (json['idBangBangCaps'] != null) {
      idBangBangCap = json['idBangBangCaps'] as List<dynamic>;
    }

    if (json['anhHoSoXinViecs'] != null) {
      anhHoSoXinViecs = json['anhHoSoXinViecs'] as List<dynamic>;
    }

    if (json['idNgoaiNgus'] != null) {
      idNgoaiNgu = json['idNgoaiNgus'] as List<dynamic>;
    }

    if (json['idKeKhaiKinhNghiems'] != null) {
      idKeKhaiKinhNghiem = json['idKeKhaiKinhNghiems'] as List<dynamic>;
    }

    fileHoSoXinViec = json['fileHoSoXinViec'].toString();

    if (json['idNganhNgheMongMuons'] != null) {
      idNganhNgheMongMuons = json['idNganhNgheMongMuons'] as List<dynamic>;
    }

    idTinHoc = json['idTinHoc'].toString();
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
    if (mucTieuNgheNghiep != null) {
      data['mucTieuNgheNghiep'] = mucTieuNgheNghiep;
    }

    // check null idBangBangCap
    if (idBangBangCap != null) data['idBangBangCaps'] = idBangBangCap;

    // check null chucVuHienTai
    if (chucVuHienTai != null) data['chucVuHienTai'] = chucVuHienTai;

    // check null chucVuMongMuon
    if (chucVuMongMuon != null) data['chucVuMongMuon'] = chucVuMongMuon;

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null) {
      data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;
    }

    // check null noiLamViec
    if (noiLamViec != null) data['noiLamViecs'] = noiLamViec;

    ///
    ///Bổ sung
    ///

    //check null phanMemHoTro
    if (phanMemHoTro != null) data['phanMemHoTro'] = phanMemHoTro;

    //check null soThichTrinhDo
    if (soThichTrinhDo != null) data['soThichTrinhDo'] = soThichTrinhDo;

    //check null soThichKyNang
    if (soThichKyNang != null) data['soThichKyNang'] = soThichKyNang;

    //check null soTichTinhCach
    if (soTichTinhCach != null) data['soTichTinhCach'] = soTichTinhCach;

    //check null idMucLuongDuKien
    if (idMucLuongDuKien != null) data['idMucLuongDuKien'] = idMucLuongDuKien;

    ///
    ///Tham khảo
    ///

    //check null nguoiThamKhao
    if (nguoiThamKhao != null) data['nguoiThamKhao'] = nguoiThamKhao;

    //check null chucDanh
    if (chucDanh != null) data['chucDanh'] = chucDanh;

    //check null congTy
    if (congTy != null) data['congTy'] = congTy;

    //check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai;

    //check null emailThamKhao
    if (emailThamKhao != null) data['emailThamKhao'] = emailThamKhao;

    // check null mucLuongDeXuat
    if (mucLuongDeXuat != null) data['mucLuongDeXuat'] = mucLuongDeXuat;

    // check null idKeKhaiKinhNghiem
    if (idKeKhaiKinhNghiem != null) {
      data['idKeKhaiKinhNghiems'] = idKeKhaiKinhNghiem;
    }

    // check null fileHoSoXinViec

    if (fileHoSoXinViec != null) {
      data['fileHoSoXinViec'] = fileHoSoXinViec;
    }

    // check null kyNangSoTruong
    if (kyNangSoTruong != null) data['kyNangSoTruong'] = kyNangSoTruong;

    // check null idNgoaiNgu
    if (idNgoaiNgu != null) data['idNgoaiNgus'] = idNgoaiNgu;

    // check null idHinhThucLamViec
    if (idHinhThucLamViec != null) {
      data['idHinhThucLamViec'] = idHinhThucLamViec;
    }

    // check null idNhomDichVu
    if (idNhomDichVu != null) {
      data['idNhomDichVu'] = idNhomDichVu;
    }

    // check null idLoaiCongViec
    if (idLoaiCongViec != null) {
      data['idLoaiCongViec'] = idLoaiCongViec;
    }

    // check null thoiGianBatDau
    if (thoiGianBatDau != null) {
      data['thoiGianBatDau'] = thoiGianBatDau;
    }

    // check null thoiGianKetThuc
    if (thoiGianKetThuc != null) {
      data['thoiGianKetThuc'] = thoiGianKetThuc;
    }

    // check null soLuong
    if (soLuong != null) {
      data['soLuong'] = soLuong;
    }

    // check null idDiaDiemDangKyLamViecs
    if (idDiaDiemDangKyLamViecs != null) {
      data['idDiaDiemDangKyLamViecs'] = idDiaDiemDangKyLamViecs;
    }

    // check null tieuDeSearch
    if (tieuDeSearch != null) {
      data['tieuDeSearch'] = tieuDeSearch;
    }

    // check null anhHoSo
    if (anhHoSoXinViecs != null) {
      data['anhHoSoXinViecs'] = anhHoSoXinViecs;
    }

    // check null idNganhNgheMongMuons
    if (idNganhNgheMongMuons != null) {
      data['idNganhNgheMongMuons'] = idNganhNgheMongMuons;
    }

    // check null idTinHoc
    if (idTinHoc != null) {
      data['idTinHoc'] = idTinHoc;
    }

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    // tieuDeSearch
    return data;
  }

  @override
  String toString() {
    return idDiaDiemDangKyLamViecs.toString();
  }
}
