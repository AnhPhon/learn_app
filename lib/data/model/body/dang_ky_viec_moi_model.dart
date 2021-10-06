class DangKyViecMoiModel {
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

  DangKyViecMoiModel({
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
      this.idTinHoc
      });

  DangKyViecMoiModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    data['tenUngVien'] = tenUngVien;
    data['gioiTinh'] = gioiTinh;
    data['ngaySinh'] = ngaySinh;
    data['email'] = email;
    data['diaChi'] = diaChi;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['honNhan'] = honNhan;
    data['idLoaiNhanVien'] = idLoaiNhanVien;
    data['mucTieuNgheNghiep'] = mucTieuNgheNghiep;
    data['idBangBangCap'] = idBangBangCap;
    data['chucVuHienTai'] = chucVuHienTai;
    data['chucVuMongMuon'] = chucVuMongMuon;
    data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;
    data['noiLamViec'] = noiLamViec;
    data['mucLuongDeXuat'] = mucLuongDeXuat;
    data['idKeKhaiKinhNghiem'] = idKeKhaiKinhNghiem;
    data['anhHoSoXinViec'] = anhHoSoXinViec;
    data['fileHoSoXinViec'] = fileHoSoXinViec;
    data['kyNangSoTruong'] = kyNangSoTruong;
    data['idNgoaiNgu'] = idNgoaiNgu;
    data['idTinHoc'] = idTinHoc;
    return data;
  }
}
