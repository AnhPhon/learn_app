import 'nhan_vien_response.dart';
import 'du_an_nhan_vien_response.dart';
import 'kho_hang_response.dart';
import 'vat_tu_response.dart';
import 'don_vi_cung_cap_response.dart';

class XuatNhapKhoResponse {
  String? loai;
  String? id;
  NhanVienResponse? idNhanVien;
  DuAnNhanVienResponse? idDuAnNhanVien;
  KhoHangResponse? idKhoHang;
  VatTuResponse? idVatTu;
  DonViCungCapResponse? idDonViCungCap;
  String? soLuong;
  String? ghiChu;
  String? ngayXuatNhapKhoa;
  String? createdAt;
  String? updatedAt;

  XuatNhapKhoResponse(
      {this.id,
      this.loai,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.idKhoHang,
      this.idVatTu,
      this.idDonViCungCap,
      this.soLuong,
      this.ghiChu,
      this.ngayXuatNhapKhoa,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  XuatNhapKhoResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    loai = json['loai'].toString();

    // mapping idNhanVien
    if (json['idNhanVien'] != null &&
        json['idNhanVien'].toString().length != 24) {
      idNhanVien =
          NhanVienResponse.fromJson(json['idNhanVien'] as Map<String, dynamic>);
    } else {
      idNhanVien = null;
    }

    // mapping idDuAnNhanVien
    if (json['idDuAnNhanVien'] != null &&
        json['idDuAnNhanVien'].toString().length != 24) {
      idDuAnNhanVien = DuAnNhanVienResponse.fromJson(
          json['idDuAnNhanVien'] as Map<String, dynamic>);
    } else {
      idDuAnNhanVien = null;
    }

    // mapping idKhoHang
    if (json['idKhoHang'] != null &&
        json['idKhoHang'].toString().length != 24) {
      idKhoHang =
          KhoHangResponse.fromJson(json['idKhoHang'] as Map<String, dynamic>);
    } else {
      idKhoHang = null;
    }

    // mapping idVatTu
    if (json['idVatTu'] != null && json['idVatTu'].toString().length != 24) {
      idVatTu = VatTuResponse.fromJson(json['idVatTu'] as Map<String, dynamic>);
    } else {
      idVatTu = null;
    }

    // mapping idDonViCungCap
    if (json['idDonViCungCap'] != null &&
        json['idDonViCungCap'].toString().length != 24) {
      idDonViCungCap = DonViCungCapResponse.fromJson(
          json['idDonViCungCap'] as Map<String, dynamic>);
    } else {
      idDonViCungCap = null;
    }
    soLuong = json['soLuong'].toString();
    ghiChu = json['ghiChu'].toString();
    ngayXuatNhapKhoa = json['ngayXuatNhapKhoa'].toString();

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

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien;

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien;

    // check null idKhoHang
    if (idKhoHang != null) data['idKhoHang'] = idKhoHang;

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu;

    // check null idDonViCungCap
    if (idDonViCungCap != null) data['idDonViCungCap'] = idDonViCungCap;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null xuat nhap kho
    if (ngayXuatNhapKhoa != null) data['ngayXuatNhapKhoa'] = ngayXuatNhapKhoa;
    return data;
  }
}
