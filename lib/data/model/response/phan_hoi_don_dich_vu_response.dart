import 'package:template/data/model/response/yeu_cau_bao_hanh_response.dart';

import 'don_dich_vu_response.dart';
import 'tai_khoan_response.dart';

class PhanHoiDonDichVuResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  TaiKhoanResponse? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? yKienThoThau;
  String? yKienThoThauViecDaLam;
  String? khachHangDanhGia;
  String? khachHangDanhGiaViecDaLam;
  String? yeuCauBaoHanh;
  String? hinhAnhHuHai;
  String? noiDungYeuCauBaoHanh;
  String? danhGiaBaoHanh;
  String? tinhTrangThanhToan;
  String? kichHoatBaoHanh;
  List<YeuCauBaoHanhResponse>? idYeuCauBaoHanhs;

  String? createdAt;
  String? updatedAt;

  PhanHoiDonDichVuResponse(
      {this.id,
      this.idDonDichVu,
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.yKienThoThau,
      this.yKienThoThauViecDaLam,
      this.khachHangDanhGia,
      this.khachHangDanhGiaViecDaLam,
      this.yeuCauBaoHanh,
      this.hinhAnhHuHai,
      this.noiDungYeuCauBaoHanh,
      this.danhGiaBaoHanh,
      this.tinhTrangThanhToan,
      this.kichHoatBaoHanh,
      this.idYeuCauBaoHanhs,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  PhanHoiDonDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idDonDichVu
    if (json['idDonDichVu'] != null &&
        json['idDonDichVu'].toString().length != 24) {
      idDonDichVu = DonDichVuResponse.fromJson(
          json['idDonDichVu'] as Map<String, dynamic>);
    } else {
      idDonDichVu = null;
    }

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    yKienThoThau = json['yKienThoThau'].toString();
    yKienThoThauViecDaLam = json['yKienThoThauViecDaLam'].toString();
    khachHangDanhGia = json['khachHangDanhGia'].toString();
    khachHangDanhGiaViecDaLam = json['khachHangDanhGiaViecDaLam'].toString();
    yeuCauBaoHanh = json['yeuCauBaoHanh'].toString();
    hinhAnhHuHai = json['hinhAnhHuHai'].toString();
    noiDungYeuCauBaoHanh = json['noiDungYeuCauBaoHanh'].toString();
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    tinhTrangThanhToan = json['tinhTrangThanhToan'].toString();
    kichHoatBaoHanh = json['kichHoatBaoHanh'].toString();

    // mapping idYeuCauBaoHanhs
    if (json['idYeuCauBaoHanhs'] != null &&
        (json['idYeuCauBaoHanhs'] as List<dynamic>).isNotEmpty &&
        json['idYeuCauBaoHanhs'].toString().length != 24) {
      idYeuCauBaoHanhs = (json['idYeuCauBaoHanhs'] as List<dynamic>)
          .map((e) => YeuCauBaoHanhResponse.fromJson((e.toString().length != 24
              ? e
              : {'id': e.toString()}) as Map<String, dynamic>))
          .toList();
    } else {
      idYeuCauBaoHanhs = [];
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

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu;

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon;

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

    // check null kichHoatBaoHanh
    if (kichHoatBaoHanh != null) data['kichHoatBaoHanh'] = kichHoatBaoHanh;

    // check null idYeuCauBaoHanhs
    if (idYeuCauBaoHanhs != null) data['idYeuCauBaoHanhs'] = idYeuCauBaoHanhs;

    return data;
  }
}
