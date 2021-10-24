import 'tai_khoan_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'loai_nhan_vien_response.dart';
import 'bang_bang_cap_response.dart';
import 'so_nam_kinh_nghiem_response.dart';
import 'ke_khai_kinh_nghiem_response.dart';
import 'ngoai_ngu_response.dart';
import 'tin_hoc_response.dart';

class DangKyViecMoiResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? tieuDe;
  String? tenUngVien;
  String? gioiTinh;
  String? ngaySinh;
  String? email;
  String? diaChi;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? honNhan;
  LoaiNhanVienResponse? idLoaiNhanVien;
  String? mucTieuNgheNghiep;
  BangBangCapResponse? idBangBangCap;
  String? chucVuHienTai;
  String? chucVuMongMuon;
  SoNamKinhNghiemResponse? idSoNamKinhNghiem;
  String? noiLamViec;
  String? mucLuongDeXuat;
  KeKhaiKinhNghiemResponse? idKeKhaiKinhNghiem;
  String? anhHoSoXinViec;
  String? fileHoSoXinViec;
  String? kyNangSoTruong;
  NgoaiNguResponse? idNgoaiNgu;
  TinHocResponse? idTinHoc;

  String? createdAt;
  String? updatedAt;

  DangKyViecMoiResponse(
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
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  DangKyViecMoiResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    tieuDe = json['tieuDe'].toString();
    tenUngVien = json['tenUngVien'].toString();
    gioiTinh = json['gioiTinh'].toString();
    ngaySinh = json['ngaySinh'].toString();
    email = json['email'].toString();
    diaChi = json['diaChi'].toString();

    // mapping idTinhTp
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length != 24) {
      idTinhTp =
          TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>);
    } else {
      idTinhTp = null;
    }

    // mapping idQuanHuyen
    if (json['idQuanHuyen'] != null &&
        json['idQuanHuyen'].toString().length != 24) {
      idQuanHuyen = QuanHuyenResponse.fromJson(
          json['idQuanHuyen'] as Map<String, dynamic>);
    } else {
      idQuanHuyen = null;
    }

    // mapping idPhuongXa
    if (json['idPhuongXa'] != null &&
        json['idPhuongXa'].toString().length != 24) {
      idPhuongXa =
          PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>);
    } else {
      idPhuongXa = null;
    }
    honNhan = json['honNhan'].toString();

    // mapping idLoaiNhanVien
    if (json['idLoaiNhanVien'] != null &&
        json['idLoaiNhanVien'].toString().length != 24) {
      idLoaiNhanVien = LoaiNhanVienResponse.fromJson(
          json['idLoaiNhanVien'] as Map<String, dynamic>);
    } else {
      idLoaiNhanVien = null;
    }
    mucTieuNgheNghiep = json['mucTieuNgheNghiep'].toString();

    // mapping idBangBangCap
    if (json['idBangBangCap'] != null &&
        json['idBangBangCap'].toString().length != 24) {
      idBangBangCap = BangBangCapResponse.fromJson(
          json['idBangBangCap'] as Map<String, dynamic>);

      //add list Bằng cấp
      // idBangBangCap = [];
      // final results = json['idBangBangCap'] as List<dynamic>;
      // for (final element in results) {
      //   if (element != null && element.toString().length != 24) {
      //     idBangBangCap!.add(BangBangCapResponse.fromJson(
      //         element as Map<String, dynamic>));
      //   }
      // }
    } else {
      idBangBangCap = null;
    }
    chucVuHienTai = json['chucVuHienTai'].toString();
    chucVuMongMuon = json['chucVuMongMuon'].toString();

    // mapping idSoNamKinhNghiem
    if (json['idSoNamKinhNghiem'] != null &&
        json['idSoNamKinhNghiem'].toString().length != 24) {
      idSoNamKinhNghiem = SoNamKinhNghiemResponse.fromJson(
          json['idSoNamKinhNghiem'] as Map<String, dynamic>);
    } else {
      idSoNamKinhNghiem = null;
    }
    noiLamViec = json['noiLamViec'].toString();
    mucLuongDeXuat = json['mucLuongDeXuat'].toString();

    // mapping idKeKhaiKinhNghiem
    if (json['idKeKhaiKinhNghiem'] != null &&
        json['idKeKhaiKinhNghiem'].toString().length != 24) {
      idKeKhaiKinhNghiem = KeKhaiKinhNghiemResponse.fromJson(
          json['idKeKhaiKinhNghiem'] as Map<String, dynamic>);
    } else {
      idKeKhaiKinhNghiem = null;
    }
    anhHoSoXinViec = json['anhHoSoXinViec'].toString();
    fileHoSoXinViec = json['fileHoSoXinViec'].toString();
    kyNangSoTruong = json['kyNangSoTruong'].toString();

    // mapping idNgoaiNgu
    if (json['idNgoaiNgu'] != null &&
        json['idNgoaiNgu'].toString().length != 24) {
      idNgoaiNgu =
          NgoaiNguResponse.fromJson(json['idNgoaiNgu'] as Map<String, dynamic>);
    } else {
      idNgoaiNgu = null;
    }

    // mapping idTinHoc
    if (json['idTinHoc'] != null && json['idTinHoc'].toString().length != 24) {
      idTinHoc =
          TinHocResponse.fromJson(json['idTinHoc'] as Map<String, dynamic>);
    } else {
      idTinHoc = null;
    }

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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

    return data;
  }
}
