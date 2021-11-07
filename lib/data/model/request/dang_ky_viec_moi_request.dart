import 'package:template/data/model/response/tinh_tp_response.dart';

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
  List<String>? idBangBangCap;
  String? chucVuHienTai;
  String? chucVuMongMuon;
  String? idSoNamKinhNghiem;
  String? noiLamViec;
  String? mucLuongDeXuat;
  String? idKeKhaiKinhNghiem;

  String? fileHoSoXinViec;
  String? kyNangSoTruong;
  String? idNgoaiNgu;
  String? idTinHoc;
  String? idHinhThucLamViec;
  String? idNhomDichVu;
  String? idLoaiCongViec;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? soLuong;
  String? tieuDeSearch;
  List<dynamic>? idDiaDiemDangKyLamViecs;
  List<dynamic>? anhHoSoXinViecs;
  List<String>? anhBangCaps;

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
    this.anhBangCaps,
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
    noiLamViec = json['noiLamViec'].toString();
    mucLuongDeXuat = json['mucLuongDeXuat'].toString();
    idKeKhaiKinhNghiem = json['idKeKhaiKinhNghiem'].toString();

    fileHoSoXinViec = json['fileHoSoXinViec'].toString();
    kyNangSoTruong = json['kyNangSoTruong'].toString();
    idNgoaiNgu = json['idNgoaiNgu'].toString();
    idTinHoc = json['idTinHoc'].toString();
    idHinhThucLamViec = json['idHinhThucLamViec'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    idLoaiCongViec = json['idLoaiCongViec'].toString();

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

    if (json['idBangBangCap'] != null) {
      idBangBangCap = json['idBangBangCap'] as List<String>;
    }

    if (json['anhHoSoXinViecs'] != null) {
      anhHoSoXinViecs = json['anhHoSoXinViecs'] as List<dynamic>;
    }

    // if (json['anhBangCaps'] != null) {
    //   anhBangCaps = json['anhBangCaps'] as List<String>;
    // }
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
    if (idBangBangCap != null) data['idBangBangCap'] = idBangBangCap;

    // check null chucVuHienTai
    if (chucVuHienTai != null) data['chucVuHienTai'] = chucVuHienTai;

    // check null chucVuMongMuon
    if (chucVuMongMuon != null) data['chucVuMongMuon'] = chucVuMongMuon;

    // check null idSoNamKinhNghiem
    if (idSoNamKinhNghiem != null) {
      data['idSoNamKinhNghiem'] = idSoNamKinhNghiem;
    }

    // check null noiLamViec
    if (noiLamViec != null) data['noiLamViec'] = noiLamViec;

    // check null mucLuongDeXuat
    if (mucLuongDeXuat != null) data['mucLuongDeXuat'] = mucLuongDeXuat;

    // check null idKeKhaiKinhNghiem
    if (idKeKhaiKinhNghiem != null) {
      data['idKeKhaiKinhNghiem'] = idKeKhaiKinhNghiem;
    }

    // check null fileHoSoXinViec
    if (fileHoSoXinViec != null) data['fileHoSoXinViec'] = fileHoSoXinViec;

    // check null kyNangSoTruong
    if (kyNangSoTruong != null) data['kyNangSoTruong'] = kyNangSoTruong;

    // check null idNgoaiNgu
    if (idNgoaiNgu != null) data['idNgoaiNgu'] = idNgoaiNgu;

    // check null idTinHoc
    if (idTinHoc != null) data['idTinHoc'] = idTinHoc;

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

    // check null anhbangCap
    // if (anhBangCaps != null) {
    //   data['anhBangCaps'] = anhBangCaps;
    // }
    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    // tieuDeSearch
    return data;
  }
}
