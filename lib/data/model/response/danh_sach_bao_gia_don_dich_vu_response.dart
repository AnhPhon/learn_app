import 'package:template/data/model/response/gai_vat_tu.dart';
import 'package:template/data/model/response/gia_cong_viec.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/trang_thai_bao_gia_response.dart';

import 'don_dich_vu_response.dart';

class DanhSachBaoGiaDonDichVuResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  TaiKhoanResponse? idTaiKhoanBaoGia;
  String? tongTien;
  List<GiaCongViecs>? giaCongViecs;
  String? giaBao;
  String? ghiChu;
  String? file;
  TrangThaiBaoGiaResponse? idTrangThaiBaoGia;
  String? daXem;
  String? thoiGianVanChuyenBatDau;
  String? thoiGianVanChuyenKetThuc;
  String? phiVanChuyen;
  List<dynamic>? giaVatTus;
  List<dynamic>? hinhAnhBaoGias;

  String? createdAt;
  String? updatedAt;

  DanhSachBaoGiaDonDichVuResponse({
    this.id,
    this.idDonDichVu,
    this.idTaiKhoanBaoGia,
    this.giaBao,
    this.ghiChu,
    this.file,
    this.daXem,
    this.idTrangThaiBaoGia,
    this.giaVatTus,
    this.thoiGianVanChuyenBatDau,
    this.thoiGianVanChuyenKetThuc,
    this.phiVanChuyen,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuResponse.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != null &&
        json['_id'].toString().isNotEmpty &&
        json['_id'].toString() != 'null') {
      id = (json['_id'] == null) ? null : json['_id'].toString();
    } else {
      id = (json['id'] == null) ? null : json['id'].toString();
    }

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

    thoiGianVanChuyenBatDau = json['thoiGianVanChuyenBatDau'].toString();
    thoiGianVanChuyenKetThuc = json['thoiGianVanChuyenKetThuc'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    phiVanChuyen = json['phiVanChuyen'].toString();
    file = json['file'] != null ? json['file'] as String : null;
    // giaVatTus = json['giaVatTus'] as List<dynamic>;
    // trangThaiBaoGia = json['trangThaiBaoGia'].toString();
    daXem = json['daXem'].toString();
    if (json['hinhAnhBaoGias'] != null) {
      hinhAnhBaoGias = json['hinhAnhBaoGias'] as List<dynamic>;
    }
    if (json['giaVatTus'] != null &&
        json['giaVatTus'].toString().length != 24) {
      giaVatTus = (json['giaVatTus'] as List<dynamic>)
          .map((e) => GiaVatTus.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    if (json['giaCongViecs'] != null &&
        json['giaCongViecs'].toString().length != 24) {
      giaCongViecs = (json['giaCongViecs'] as List<dynamic>)
          .map((e) => GiaCongViecs.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    // mapping idTrangThaiBaoGia
    if (json['idTrangThaiBaoGia'] != null &&
        json['idTrangThaiBaoGia'].toString().length != 24) {
      idTrangThaiBaoGia = TrangThaiBaoGiaResponse.fromJson(
          json['idTrangThaiBaoGia'] as Map<String, dynamic>);
    } else {
      idTrangThaiBaoGia = null;
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

    // check null taiKhoanBaoGia
    if (idTaiKhoanBaoGia != null) data['idTaiKhoanBaoGia'] = idTaiKhoanBaoGia;

    // check null trangThaiBaoGia
    if (phiVanChuyen != null) data['phiVanChuyen'] = phiVanChuyen;

    // check null trangThaiBaoGia
    if (idTrangThaiBaoGia != null) {
      data['idTrangThaiBaoGia'] = idTrangThaiBaoGia;
    }

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null file
    if (file != null) data['file'] = file;

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null giaVatTus
    if (giaVatTus != null) data['giaVatTus'] = giaVatTus;

    // check null daXem
    if (hinhAnhBaoGias != null) data['hinhAnhBaoGias'] = hinhAnhBaoGias;

    // check null thoiGianVanChuyenBatDau
    if (thoiGianVanChuyenBatDau != null) {
      data['thoiGianVanChuyenBatDau'] = thoiGianVanChuyenBatDau;
    }

    // check null thoiGianVanChuyenKetThuc
    if (thoiGianVanChuyenKetThuc != null) {
      data['thoiGianVanChuyenKetThuc'] = thoiGianVanChuyenKetThuc;
    }

    return data;
  }
}
