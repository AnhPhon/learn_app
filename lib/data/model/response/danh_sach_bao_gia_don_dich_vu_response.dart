import 'dart:convert';

import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/gai_vat_tu.dart';
import 'package:template/data/model/response/gia_cong_viec.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';

import 'don_dich_vu_response.dart';

class DanhSachBaoGiaDonDichVuResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  TaiKhoanResponse? idTaiKhoanBaoGia;
  String? tongTien;
  List<GiaVatTus>? giaVatTus;
  List<GiaCongViecs>? giaCongViecs;
  String? giaBao;
  String? ghiChu;
  String? file;
  String? trangThaiBaoGia;
  String? daXem;
  List<dynamic>? hinhAnhBaoGias;

  String? createdAt;
  String? updatedAt;

  DanhSachBaoGiaDonDichVuResponse(
      {this.id,
      this.idDonDichVu,
      this.idTaiKhoanBaoGia,
      this.giaBao,
      this.ghiChu,
      this.file,
      this.daXem,
      this.trangThaiBaoGia,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    id = (json['_id'] == null) ? null : json['_id'].toString();
    tongTien = (json['tongTien'] == null) ? null : json['tongTien'].toString();

    // mapping idDonDichVu
    if (json['idDonDichVu'] != null &&
        json['idDonDichVu'].toString().length != 24) {
      idDonDichVu = DonDichVuResponse.fromJson(
          json['idDonDichVu'] as Map<String, dynamic>);
    } else {
      idDonDichVu = null;
    }


    if (json['idTaiKhoanBaoGia'] != null &&
        json['idTaiKhoanBaoGia'].toString().length != 24) {
      idTaiKhoanBaoGia = TaiKhoanResponse.fromJson(
          json['idTaiKhoanBaoGia'] as Map<String, dynamic>);
    }
    // taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();

    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    file = json['file'].toString();
    trangThaiBaoGia = json['trangThaiBaoGia'].toString();
    daXem = json['daXem'].toString();
    if (json['hinhAnhBaoGias'] != null) {
      hinhAnhBaoGias = json['hinhAnhBaoGias'] as List<dynamic>;
    }
    if(json['giaVatTus'] != null) giaVatTus = (json['giaVatTus'] as List<dynamic>).map((e) => GiaVatTus.fromMap(e as Map<String, dynamic>)).toList();
    if(json['giaCongViecs'] != null) giaCongViecs = (json['giaCongViecs'] as List<dynamic>).map((e) => GiaCongViecs.fromMap(e as Map<String, dynamic>)).toList();

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

    // check null taiKhoanBaoGia
    if (idTaiKhoanBaoGia != null) data['idTaiKhoanBaoGia'] = idTaiKhoanBaoGia;

    // check null trangThaiBaoGia
    if (trangThaiBaoGia != null) data['trangThaiBaoGia'] = trangThaiBaoGia;

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null file
    if (file != null) data['file'] = file;

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null daXem
    if (hinhAnhBaoGias != null) data['hinhAnhBaoGias'] = hinhAnhBaoGias;

    return data;
  }
}

