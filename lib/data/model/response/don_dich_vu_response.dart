import 'package:template/data/model/response/trang_thai_don_dich_vu_response.dart';

import 'tai_khoan_response.dart';
import 'nhom_dich_vu_response.dart';
import 'trang_thai_don_hang_response.dart';
import 'hinh_thuc_thanh_toan_response.dart';
import 'trang_thai_thanh_toan_response.dart';
import 'thoi_gian_lam_viec_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'bang_gia_don_hang_response.dart';
import 'thong_so_ky_thuat_response.dart';

class DonDichVuResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  NhomDichVuResponse? idNhomDichVu;
  String? tieuDe;
  String? moTa;
  String? ngayBatDau;
  String? ngayKetThuc;
  List<String>? hinhAnhBanKhoiLuongs;
  String? hinhAnhBanVe;
  TrangThaiDonHangResponse? idTrangThaiDonHang;
  TrangThaiDonDichVuResponse? idTrangThaiDonDichVu;
  HinhThucThanhToanResponse? idHinhThucThanhToan;
  TrangThaiThanhToanResponse? idTrangThaiThanhToan;
  List<ThoiGianLamViecResponse>? idThoiGianLamViecs;
  List<ThongSoKyThuatResponse>? idThongSoKyThuats;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? giaTriKhachDeXuat;
  String? hinhAnhChiTiet;
  String? moTaChiTiet;
  String? file;
  String? soLuongYeuCau;
  String? soNgay;
  String? diaDiemLamViec;
  BangGiaDonHangResponse? idBangGiaDonHang;
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

  String? createdAt;
  String? updatedAt;

  DonDichVuResponse(
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
      this.hinhAnhChiTiet,
      this.moTaChiTiet,
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
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  DonDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }

    // mapping idNhomDichVu
    if (json['idNhomDichVu'] != null &&
        json['idNhomDichVu'].toString().length != 24) {
      idNhomDichVu = NhomDichVuResponse.fromJson(
          json['idNhomDichVu'] as Map<String, dynamic>);
    } else {
      idNhomDichVu = null;
    }
    tieuDe = json['tieuDe'].toString();
    moTa = json['moTa'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    hinhAnhBanKhoiLuongs = (json['hinhAnhBanKhoiLuongs'] as List<dynamic>).map((e) => e.toString()).toList();
    hinhAnhBanVe = json['hinhAnhBanVe'].toString();

    // mapping idTrangThaiDonDichVu
    if (json['idTrangThaiDonDichVu'] != null &&
        json['idTrangThaiDonDichVu'].toString().length != 24) {
      idTrangThaiDonDichVu = TrangThaiDonDichVuResponse.fromJson(
          json['idTrangThaiDonDichVu'] as Map<String, dynamic>);
    } else {
      idTrangThaiDonDichVu = null;
    }

    // mapping idTrangThaiDonDichVu
    if (json['idTrangThaiDonDichVu'] != null &&
        json['idTrangThaiDonDichVu'].toString().length != 24) {
      idTrangThaiDonDichVu = TrangThaiDonDichVuResponse.fromJson(
          json['idTrangThaiDonDichVu'] as Map<String, dynamic>);
    } else {
      idTrangThaiDonHang = null;
    }

    // mapping idHinhThucThanhToan
    if (json['idHinhThucThanhToan'] != null &&
        json['idHinhThucThanhToan'].toString().length != 24) {
      idHinhThucThanhToan = HinhThucThanhToanResponse.fromJson(
          json['idHinhThucThanhToan'] as Map<String, dynamic>);
    } else {
      idHinhThucThanhToan = null;
    }

    // mapping idTrangThaiThanhToan
    if (json['idTrangThaiThanhToan'] != null &&
        json['idTrangThaiThanhToan'].toString().length != 24) {
      idTrangThaiThanhToan = TrangThaiThanhToanResponse.fromJson(
          json['idTrangThaiThanhToan'] as Map<String, dynamic>);
    } else {
      idTrangThaiThanhToan = null;
    }

    // mapping idThoiGianLamViec
    if (json['idThoiGianLamViecs'] != null &&
        json['idThoiGianLamViecs'].toString().length != 24) {
          idThoiGianLamViecs = [];
      final result = (json['idThoiGianLamViecs'] as List<dynamic>);
          result.forEach((element) {
            if(element != null && element.toString().length != 24) {
              //result.map((e) =>
                  idThoiGianLamViecs!.add(ThoiGianLamViecResponse.fromJson(element as Map<String, dynamic>));
            }
          });
    } else {
      idThoiGianLamViecs = [];
    }
    // final results = apiResponse.response.data as List<dynamic>;
    //   onSuccess(results
    //       .map((e) => BangGiaLocHoSoResponse.fromJson(e as Map<String, dynamic>))
    //       .toList());

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
    giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();
    hinhAnhChiTiet = json['hinhAnhChiTiet'].toString();
    moTaChiTiet = json['moTaChiTiet'].toString();
    file = json['file'].toString();
    soLuongYeuCau = json['soLuongYeuCau'].toString();
    soNgay = json['soNgay'].toString();
    diaDiemLamViec = json['diaDiemLamViec'].toString();

    // mapping idBangGiaDonHang
    if (json['idBangGiaDonHang'] != null &&
        json['idBangGiaDonHang'].toString().length != 24) {
      idBangGiaDonHang = BangGiaDonHangResponse.fromJson(
          json['idBangGiaDonHang'] as Map<String, dynamic>);
    } else {
      idBangGiaDonHang = null;
    }
    gioiTinh = json['gioiTinh'].toString();

    // mapping idThongSoKyThuats
    if (json['idThongSoKyThuats'] != null &&
        json['idThongSoKyThuats'].toString().length != 24) {
      idThongSoKyThuats = (json['idThongSoKyThuats'] as List<dynamic>)
          .map(
              (e) => ThongSoKyThuatResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      idThongSoKyThuats = [];
    }
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
      data['hinhAnhBanKhoiLuongs'] = hinhAnhBanKhoiLuongs!.map((e) => e.toString()).toList();
    }

    // check null hinhAnhBanVe
    if (hinhAnhBanVe != null) data['hinhAnhBanVe'] = hinhAnhBanVe;

    // check null idTrangThaiDonDichVu
    if (idTrangThaiDonDichVu != null)
      data['idTrangThaiDonDichVu'] = idTrangThaiDonDichVu;

    // check null idTrangThaiDonDichVu
    if (idTrangThaiDonDichVu != null)
      data['idTrangThaiDonDichVu'] = idTrangThaiDonDichVu;

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null)
      data['idHinhThucThanhToan'] = idHinhThucThanhToan;

    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null)
      data['idTrangThaiThanhToan'] = idTrangThaiThanhToan;

    // check null idThoiGianLamViec
    if (idThoiGianLamViecs != null)
      data['idThoiGianLamViecs'] = idThoiGianLamViecs;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null giaTriKhachDeXuat
    if (giaTriKhachDeXuat != null)
      data['giaTriKhachDeXuat'] = giaTriKhachDeXuat;

    // check null hinhAnhChiTiet
    if (hinhAnhChiTiet != null) data['hinhAnhChiTiet'] = hinhAnhChiTiet;

    // check null moTaChiTiet
    if (moTaChiTiet != null) data['moTaChiTiet'] = moTaChiTiet;

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
      data['idThongSoKyThuats'] = idThongSoKyThuats;

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

    return data;
  }
}
