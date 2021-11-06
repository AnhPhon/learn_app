import 'dart:convert';
import 'dart:io' as io;
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';

class DonDichVuRequest {
  String? id;
  String? idTaiKhoan;
  String? idNhomDichVu;
  String? tieuDe;
  String? moTa;
  String? ngayBatDau;
  String? ngayKetThuc;
  List<String>? hinhAnhBanKhoiLuongs;
  String? hinhAnhBanVe;
  String? idTrangThaiDonHang;
  String? idTrangThaiDonDichVu;
  String? idHinhThucThanhToan;
  String? idTrangThaiThanhToan;
  List<ThoiGianLamViecResponse>? thoiGianLamViec;
  List<String>? idThoiGianLamViecs;
  List<String>? idThongSoKyThuats;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? giaTriKhachDeXuat;
  List<String>? hinhAnhChiTiets;
  String? hinhAnhChiTiet;
  String? moTaChiTiet;
  List<String>? files;
  String? file;
  String? soLuongYeuCau;
  String? soNgay;
  String? diaDiemLamViec;
  String? idBangGiaDonHang;
  String? gioiTinh;
  String? diaDiemBocHang;
  String? diaDiemTraHang;
  String? cuLyVanChuyen;
  String? beRongDiemNhan;
  String? beRongDiemTra;
  String? hinhAnhBaoGia;
  String? phiDichVu;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? taiKhoanNhanDon;
  String? tienCoc;
  String? diaChiCuThe;

  DonDichVuRequest(
      {this.id,
      this.idTaiKhoan,
      this.idNhomDichVu,
      this.tieuDe,
      this.moTa,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hinhAnhBanKhoiLuongs,
      this.hinhAnhBanVe,
      this.idTrangThaiDonHang,
      this.idTrangThaiDonDichVu,
      this.idHinhThucThanhToan,
      this.idTrangThaiThanhToan,
      this.idThoiGianLamViecs,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.giaTriKhachDeXuat,
      this.hinhAnhChiTiets,
      this.hinhAnhChiTiet,
      this.moTaChiTiet,
      this.files,
      this.file,
      this.soLuongYeuCau,
      this.soNgay,
      this.diaDiemLamViec,
      this.idBangGiaDonHang,
      this.gioiTinh,
      this.idThongSoKyThuats,
      this.diaDiemBocHang,
      this.diaDiemTraHang,
      this.cuLyVanChuyen,
      this.beRongDiemNhan,
      this.beRongDiemTra,
      this.hinhAnhBaoGia,
      this.phiDichVu,
      this.khuyenMai,
      this.soTien,
      this.tongDon,
      this.taiKhoanNhanDon,
      this.tienCoc,
      this.diaChiCuThe});

  ///
  /// From JSON
  ///
  DonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    tieuDe = json['tieuDe'].toString();
    moTa = json['moTa'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    hinhAnhBanKhoiLuongs = (json['hinhAnhBanKhoiLuongs'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    hinhAnhBanVe = json['hinhAnhBanVe'].toString();
    idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    idTrangThaiDonDichVu = json['idTrangThaiDonDichVu'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    if (json['thoiGianLamViec'] != null) {
      thoiGianLamViec = (json['thoiGianLamViec'] as List<dynamic>)
          .map((e) =>
              ThoiGianLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();

    hinhAnhChiTiets = (json['hinhAnhChiTiets'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();

    hinhAnhChiTiet = json['hinhAnhChiTiet'].toString();
    moTaChiTiet = json['moTaChiTiet'].toString();

    files = (json['files'] as List<dynamic>).map((e) => e.toString()).toList();

    file = json['file'].toString();
    soLuongYeuCau = json['soLuongYeuCau'].toString();
    soNgay = json['soNgay'].toString();
    diaDiemLamViec = json['diaDiemLamViec'].toString();
    idBangGiaDonHang = json['idBangGiaDonHang'].toString();
    gioiTinh = json['gioiTinh'].toString();
    idThongSoKyThuats = (json['idThongSoKyThuats'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
    diaDiemBocHang = json['diaDiemBocHang'].toString();
    diaDiemTraHang = json['diaDiemTraHang'].toString();
    cuLyVanChuyen = json['cuLyVanChuyen'].toString();
    beRongDiemNhan = json['beRongDiemNhan'].toString();
    beRongDiemTra = json['beRongDiemTra'].toString();
    hinhAnhBaoGia = json['hinhAnhBaoGia'].toString();
    phiDichVu = json['phiDichVu'].toString();
    khuyenMai = json['khuyenMai'].toString();
    soTien = json['soTien'].toString();
    tongDon = json['tongDon'].toString();
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    tienCoc = json['tienCoc'].toString();
    diaChiCuThe = json['diaChiCuThe'].toString();
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

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null moTa
    if (moTa != null) data['moTa'] = moTa;

    // check null ngayBatDau
    if (ngayBatDau != null) data['ngayBatDau'] = ngayBatDau;

    // check null ngayKetThuc
    if (ngayKetThuc != null) data['ngayKetThuc'] = ngayKetThuc;

    // check null hinhAnhBanKhoiLuongs
    if (hinhAnhBanKhoiLuongs != null) {
      data['hinhAnhBanKhoiLuongs'] = hinhAnhBanKhoiLuongs;
    }

    // check null hinhAnhBanVe
    if (hinhAnhBanVe != null) data['hinhAnhBanVe'] = hinhAnhBanVe;

    // check null idTrangThaiDonDichVu
    if (idTrangThaiDonDichVu != null) {
      data['idTrangThaiDonDichVu'] = idTrangThaiDonDichVu;
    }

    // check null idTrangThaiDonHang
    if (idTrangThaiDonDichVu != null) {
      data['idTrangThaiDonDichVu'] = idTrangThaiDonDichVu;
    }

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null) {
      data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    }

    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null) {
      data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;
    }

    // check null idThoiGianLamViec
    if (idThoiGianLamViecs != null) {
      data['idThoiGianLamViecs'] = idThoiGianLamViecs!.map((e) => e).toList();
    }
    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null giaTriKhachDeXuat
    if (giaTriKhachDeXuat != null) {
      data['giaTriKhachDeXuat'] = giaTriKhachDeXuat;
    }

    // check null hinhAnhChiTiets
    if (hinhAnhChiTiets != null) {
      data['hinhAnhChiTiets'] = hinhAnhChiTiets;
    }

    // check null hinhAnhChiTiet
    if (hinhAnhChiTiet != null) data['hinhAnhChiTiet'] = hinhAnhChiTiet;

    // check null moTaChiTiet
    if (moTaChiTiet != null) data['moTaChiTiet'] = moTaChiTiet;

    // check null files
    if (files != null) {
      data['files'] = files;
    }

    // check null file
    if (file != null) data['file'] = file;

    // check null soLuongYeuCau
    if (soLuongYeuCau != null) data['soLuongYeuCau'] = soLuongYeuCau;

    // check null soNgay
    if (soNgay != null) data['soNgay'] = soNgay;

    // check null diaDiemLamViec
    if (diaDiemLamViec != null) data['diaDiemLamViec'] = diaDiemLamViec;

    // check null idBangGiaDonHang
    if (idBangGiaDonHang != null) data['idBangGiaDonHang'] = idBangGiaDonHang;

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh;

    // check null idThongSoKyThuats
    if (idThongSoKyThuats != null)
      data['idThongSoKyThuats'] = idThongSoKyThuats!.map((e) => e).toList();

    // check null diaDiemBocHang
    if (diaDiemBocHang != null) data['diaDiemBocHang'] = diaDiemBocHang;

    // check null diaDiemTraHang
    if (diaDiemTraHang != null) data['diaDiemTraHang'] = diaDiemTraHang;

    // check null cuLyVanChuyen
    if (cuLyVanChuyen != null) data['cuLyVanChuyen'] = cuLyVanChuyen;

    // check null beRongDiemNhan
    if (beRongDiemNhan != null) data['beRongDiemNhan'] = beRongDiemNhan;

    // check null beRongDiemTra
    if (beRongDiemTra != null) data['beRongDiemTra'] = beRongDiemTra;

    // check null hinhAnhBaoGia
    if (hinhAnhBaoGia != null) data['hinhAnhBaoGia'] = hinhAnhBaoGia;

    // check null phiDichVu
    if (phiDichVu != null) data['phiDichVu'] = phiDichVu;

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai;

    // check null soTien
    if (soTien != null) data['soTien'] = soTien;

    // check null tongDon
    if (tongDon != null) data['tongDon'] = tongDon;

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon;

    // check null tienCoc
    if (tienCoc != null) data['tienCoc'] = tienCoc;
    // check dịa chi cụ the
    if (diaChiCuThe != null) data['diaChiCuThe'] = diaChiCuThe;
    return data;
  }
}
