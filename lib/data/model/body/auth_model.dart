import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/izi_validate.dart';

class AuthModel {
  String? id;
  String? idRole;
  String? tinhTpHoatDong;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? loaiPhapLy;
  String? tenPhapLy;
  String? mST;
  String? hoTen;
  String? ngaySinh;
  String? gioiTinh;
  String? cMND;
  String? ngayCap;
  String? noiCap;
  String? soDienThoai;
  String? email;
  String? diaChi;
  String? viTien;
  String? hinhDaiDien;
  String? matKhau;
  String? tokenDevice;
  String? soLuongNguoi;
  String? chuyenMon;
  String? gioiThieu;
  String? noiLamViec;
  String? hinhCMNDTruoc;
  String? hinhCMNDSau;
  String? diaChiKhoHang;
  String? thoiGianLamViec;
  String? lamChieuThuBay;
  String? lamNgayChuNhat;
  String? diaDiemCuaHangChinh;
  String? diaDiemCuThe;
  String? hinhAnhKhuonMat;

  String? createdAt;
  String? updatedAt;
  String? access;
  String? refresh;
  String? resetPasswordToken;

  AuthModel(
      {this.id,
      this.idRole,
      this.tinhTpHoatDong,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.loaiPhapLy,
      this.tenPhapLy,
      this.mST,
      this.hoTen,
      this.ngaySinh,
      this.gioiTinh,
      this.cMND,
      this.ngayCap,
      this.noiCap,
      this.soDienThoai,
      this.email,
      this.diaChi,
      this.viTien,
      this.hinhDaiDien,
      this.matKhau,
      this.tokenDevice,
      this.soLuongNguoi,
      this.chuyenMon,
      this.gioiThieu,
      this.noiLamViec,
      this.hinhCMNDTruoc,
      this.hinhCMNDSau,
      this.diaChiKhoHang,
      this.thoiGianLamViec,
      this.lamChieuThuBay,
      this.lamNgayChuNhat,
      this.diaDiemCuaHangChinh,
      this.diaDiemCuThe,
      this.hinhAnhKhuonMat,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  AuthModel.fromJson(Map<String, dynamic> json) {
    // TODO: implement validate parse model json
    if(!IZIValidate.nullOrEmpty(json['id'])){
      id = json['id'].toString();
    }

    // mapping idRole
    // if (json['idRole'] != null &&
    //     json['idRole'].toString().length != 24) {
    //   idRole = LoaiTaiKhoanResponse.fromJson(
    //       json['idRole'] as Map<String, dynamic>);
    // } else {
    //   idRole = null;
    // }
    if (json['idRole'] != null) {
      idRole = json['idRole'].toString();
    }
    tinhTpHoatDong = json['tinhTpHoatDong'].toString();

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
    loaiPhapLy = json['loaiPhapLy'].toString();
    tenPhapLy = json['tenPhapLy'].toString();
    mST = json['mST'].toString();
    hoTen = json['hoTen'].toString();
    ngaySinh = json['ngaySinh'].toString();
    gioiTinh = json['gioiTinh'].toString();
    cMND = json['cMND'].toString();
    ngayCap = json['ngayCap'].toString();
    noiCap = json['noiCap'].toString();
    soDienThoai = json['soDienThoai'].toString();
    email = json['email'].toString();
    diaChi = json['diaChi'].toString();
    viTien = json['viTien'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    matKhau = json['matKhau'].toString();
    tokenDevice = json['tokenDevice'].toString();
    soLuongNguoi = json['soLuongNguoi'].toString();
    chuyenMon = json['chuyenMon'].toString();
    gioiThieu = json['gioiThieu'].toString();
    noiLamViec = json['noiLamViec'].toString();
    hinhCMNDTruoc = json['hinhCMNDTruoc'].toString();
    hinhCMNDSau = json['hinhCMNDSau'].toString();

    diaChiKhoHang = json['diaChiKhoHang'].toString();
    thoiGianLamViec = json['thoiGianLamViec'].toString();
    lamChieuThuBay = json['lamChieuThuBay'].toString();
    lamNgayChuNhat = json['lamNgayChuNhat'].toString();
    diaDiemCuaHangChinh = json['diaDiemCuaHangChinh'].toString();
    diaDiemCuThe = json['diaDiemCuThe'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    access = json['access'].toString();
    refresh = json['refresh'].toString();
    hinhAnhKhuonMat = json['hinhAnhKhuonMat'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // TODO: implement validate parse model toJson
    // check null id
    if (id != null) data['id'] = id;

    // check null idRole
    if (idRole != null) data['idRole'] = idRole;

    // check null tinhTpHoatDong
    if (tinhTpHoatDong != null) data['tinhTpHoatDong'] = tinhTpHoatDong;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null loaiPhapLy
    if (loaiPhapLy != null) data['loaiPhapLy'] = loaiPhapLy;

    // check null tenPhapLy
    if (tenPhapLy != null) data['tenPhapLy'] = tenPhapLy;

    // check null mST
    if (mST != null) data['mST'] = mST;

    // check null hoTen
    if (hoTen != null) data['hoTen'] = hoTen;

    // check null ngaySinh
    if (ngaySinh != null) data['ngaySinh'] = ngaySinh;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null cMND
    if (cMND != null) data['cMND'] = cMND;

    // check null ngayCap
    if (ngayCap != null) data['ngayCap'] = ngayCap;

    // check null noiCap
    if (noiCap != null) data['noiCap'] = noiCap;

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai;

    // check null email
    if (email != null) data['email'] = email;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null viTien
    if (viTien != null) data['viTien'] = viTien;

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien;

    // check null matKhau
    if (matKhau != null) data['matKhau'] = matKhau;

    // check null tokenDevice
    if (tokenDevice != null) data['tokenDevice'] = tokenDevice;

    // check null soLuongNguoi
    if (soLuongNguoi != null) data['soLuongNguoi'] = soLuongNguoi;

    // check null chuyenMon
    if (chuyenMon != null) data['chuyenMon'] = chuyenMon;

    // check null gioiThieu
    if (gioiThieu != null) data['gioiThieu'] = gioiThieu;

    // check null noiLamViec
    if (noiLamViec != null) data['noiLamViec'] = noiLamViec;

    // check null hinhCMNDTruoc
    if (hinhCMNDTruoc != null) data['hinhCMNDTruoc'] = hinhCMNDTruoc;

    // check null hinhCMNDSau
    if (hinhCMNDSau != null) data['hinhCMNDSau'] = hinhCMNDSau;

    // check null diaChiKhoHang
    if (diaChiKhoHang != null) data['diaChiKhoHang'] = diaChiKhoHang;

    // check null thoiGianLamViec
    if (thoiGianLamViec != null) data['thoiGianLamViec'] = thoiGianLamViec;

    // check null lamChieuThuBay
    if (lamChieuThuBay != null) data['lamChieuThuBay'] = lamChieuThuBay;

    // check null lamNgayChuNhat
    if (lamNgayChuNhat != null) data['lamNgayChuNhat'] = lamNgayChuNhat;

    // check null diaDiemCuaHangChinh
    if (diaDiemCuaHangChinh != null) {
      data['diaDiemCuaHangChinh'] = diaDiemCuaHangChinh;
    }

    // check null hinhAnhKhuonMat
    if (hinhAnhKhuonMat != null) data['hinhAnhKhuonMat'] = hinhAnhKhuonMat;

    // check null diaDiemCuThe
    if (diaDiemCuThe != null) data['diaDiemCuThe'] = diaDiemCuThe;
    if (access != null) data['access'] = access;
    if (refresh != null) data['refresh'] = refresh;
    return data;
  }
}
