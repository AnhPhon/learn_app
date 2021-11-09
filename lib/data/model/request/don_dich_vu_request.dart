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
  List<String>? hinhAnhBanVes;
  List<String>? hinhAnhChiTiets;
  List<String>? hinhAnhBaoGias;
  List<String>? hinhAnhThucTes;
  List<String>? hinhAnhBaoHanhs;
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
  String? moTaChiTiet;
  List<String>? files;
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
  String? beRongMatDuong;
  String? phiDichVu;
  String? khuyenMai;
  String? soTien;
  String? tongDon;
  String? taiKhoanNhanDon;
  String? tienCoc;
  String? diaChiCuThe;
  String? idLoaiCongViec;
  String? idTaiKhoanNhanDon;

  DonDichVuRequest(
      {this.id,
      this.idTaiKhoan,
      this.idNhomDichVu,
      this.tieuDe,
      this.moTa,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hinhAnhBanKhoiLuongs,
      this.hinhAnhBanVes,
      this.hinhAnhThucTes,
      this.idTrangThaiDonHang,
      this.idTrangThaiDonDichVu,
      this.idHinhThucThanhToan,
      this.idTrangThaiThanhToan,
      this.idThoiGianLamViecs,
      this.beRongMatDuong,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.giaTriKhachDeXuat,
      this.hinhAnhChiTiets,
      this.moTaChiTiet,
      this.files,
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
      this.hinhAnhBaoGias,
      this.phiDichVu,
      this.khuyenMai,
      this.soTien,
      this.tongDon,
      this.taiKhoanNhanDon,
      this.idLoaiCongViec,
      this.tienCoc,
      this.idTaiKhoanNhanDon,
      this.diaChiCuThe});

  ///
  /// From JSON
  ///
  DonDichVuRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    if(json['idTaiKhoan'] != null)idTaiKhoan = json['idTaiKhoan'].toString();
    if(json['idNhomDichVu'] != null)idNhomDichVu = json['idNhomDichVu'].toString();
    if(json['tieuDe'] != null) tieuDe = json['tieuDe'].toString();
    if(json['moTa'] != null)moTa = json['moTa'].toString();
    if(json['ngayBatDau'] != null)ngayBatDau = json['ngayBatDau'].toString();
    if(json['ngayKetThuc'] != null)ngayKetThuc = json['ngayKetThuc'].toString();
    if(json['hinhAnhBanKhoiLuongs'] != null) hinhAnhBanKhoiLuongs = (json['hinhAnhBanKhoiLuongs'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['hinhAnhBanVes'] != null) hinhAnhBanVes = (json['hinhAnhBanVes'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['hinhAnhChiTiets'] != null) hinhAnhChiTiets = (json['hinhAnhChiTiets'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['hinhAnhBaoGias'] != null) hinhAnhBaoGias = (json['hinhAnhBaoGias'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['hinhAnhThucTes'] != null) hinhAnhThucTes = (json['hinhAnhThucTes'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['hinhAnhBaoHanhs'] != null) hinhAnhBaoHanhs = (json['hinhAnhBaoHanhs'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['idTrangThaiDonHang'] != null) idTrangThaiDonHang = json['idTrangThaiDonHang'].toString();
    if(json['idTrangThaiDonDichVu'] != null) idTrangThaiDonDichVu = json['idTrangThaiDonDichVu'].toString();
    if(json['idHinhThucThanhToan'] != null) idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    if(json['idTrangThaiThanhToan'] != null) idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    if (json['thoiGianLamViec'] != null) {
      thoiGianLamViec = (json['thoiGianLamViec'] as List<dynamic>)
          .map((e) =>
              ThoiGianLamViecResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    if(json['idTinhTp'] != null) idTinhTp = json['idTinhTp'].toString();
    if(json['idQuanHuyen'] != null) idQuanHuyen = json['idQuanHuyen'].toString();
    if(json['idPhuongXa'] != null) idPhuongXa = json['idPhuongXa'].toString();
    if(json['giaTriKhachDeXuat'] != null) giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();
    if(json['moTaChiTiet'] != null) moTaChiTiet = json['moTaChiTiet'].toString();
    if(json['files'] != null) files = (json['files'] as List<dynamic>).map((e) => e.toString()).toList();
    if(json['soLuongYeuCau'] != null) soLuongYeuCau = json['soLuongYeuCau'].toString();
    if(json['soNgay'] != null) soNgay = json['soNgay'].toString();
    if(json['diaDiemLamViec'] != null) diaDiemLamViec = json['diaDiemLamViec'].toString();
    if(json['idBangGiaDonHang'] != null)  idBangGiaDonHang = json['idBangGiaDonHang'].toString();
    if(json['gioiTinh'] != null) gioiTinh = json['gioiTinh'].toString();
    if (json['idThongSoKyThuats'] != null) {
      idThongSoKyThuats = (json['idThongSoKyThuats'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
    }
    if(json['diaDiemBocHang'] != null) diaDiemBocHang = json['diaDiemBocHang'].toString();
    if(json['diaDiemTraHang'] != null) diaDiemTraHang = json['diaDiemTraHang'].toString();
    if(json['cuLyVanChuyen'] != null) cuLyVanChuyen = json['cuLyVanChuyen'].toString();
    if(json['beRongDiemNhan'] != null) beRongDiemNhan = json['beRongDiemNhan'].toString();
    if(json['beRongDiemTra'] != null) beRongDiemTra = json['beRongDiemTra'].toString();
    if(json['beRongMatDuong'] != null) beRongMatDuong = json['beRongMatDuong'].toString();
    if(json['phiDichVu'] != null) phiDichVu = json['phiDichVu'].toString();
    if(json['khuyenMai'] != null) khuyenMai = json['khuyenMai'].toString();
    if(json['soTien'] != null) soTien = json['soTien'].toString();
    if(json['tongDon'] != null) tongDon = json['tongDon'].toString();
    if(json['taiKhoanNhanDon'] != null) taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    if(json['tienCoc'] != null) tienCoc = json['tienCoc'].toString();
    if(json['diaChiCuThe'] != null) diaChiCuThe = json['diaChiCuThe'].toString();
    if(json['idLoaiCongViec'] != null) idLoaiCongViec = json['idLoaiCongViec'].toString();
    if(json['idTaiKhoanNhanDon'] != null) idTaiKhoanNhanDon = json['idTaiKhoanNhanDon'].toString();
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

    // check null hinhAnhBanVes
    if (hinhAnhBanVes != null) data['hinhAnhBanVes'] = hinhAnhBanVes;

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
    if (hinhAnhChiTiets != null) data['hinhAnhChiTiets'] = hinhAnhChiTiets;
    // HÌnh ảnh thực tế
    if (hinhAnhThucTes != null) data['hinhAnhThucTes'] = hinhAnhThucTes;
    // hinh Anh Bao Hanhs
    if (hinhAnhBaoHanhs != null) data['hinhAnhBaoHanhs'] = hinhAnhBaoHanhs;

    // check null moTaChiTiet
    if (moTaChiTiet != null) data['moTaChiTiet'] = moTaChiTiet;

    // check null files
    if (files != null) data['files'] = files;

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
    // check null beRongMatDuong
    if (beRongMatDuong != null) data['beRongMatDuong'] = beRongMatDuong;

    // check null hinhAnhBaoGias
    if (hinhAnhBaoGias != null) data['hinhAnhBaoGias'] = hinhAnhBaoGias;

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
    if (idLoaiCongViec != null) data['idLoaiCongViec'] = idLoaiCongViec;
    if (idTaiKhoanNhanDon != null) data['idTaiKhoanNhanDon'] = idTaiKhoanNhanDon;
    return data;
  }
}
