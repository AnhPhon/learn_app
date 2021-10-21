import 'dart:io';

import 'package:template/data/model/response/vat_tu_response.dart';

class PreviewServiceRequest {
  String? id;
  String? idTaiKhoan;
  String? idNhomDichVu;
  String? tieuDe;
  String? moTa;
  String? ngayBatDau;
  String? ngayKetThuc;
  List<VatTuResponse>? bangKhoiLuong;
  List<File>? hinhAnhBanKhoiLuong;
  List<File>? hinhAnhBanVe;
  String? idTrangThaiDonDichVu;
  String? idHinhThucThanhToan;
  String? idTrangThaiThanhToan;
  String? idThoiGianLamViec;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idPhuongXa;
  String? giaTriKhachDeXuat;
  String? hinhAnhChiTiet;
  String? moTaChiTiet;
  File? file;
  String? soLuongYeuCau;
  String? soNgay;
  String? diaDiemLamViec;
  String? idBangGiaDonHang;
  String? gioiTinh;
  String? idThongSoKyThuat;
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

  PreviewServiceRequest({
      this.id,
      this.idTaiKhoan,
      this.idNhomDichVu,
      this.tieuDe,
      this.moTa,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hinhAnhBanKhoiLuong,
      this.hinhAnhBanVe,
      this.idTrangThaiDonDichVu,
      this.idHinhThucThanhToan,
      this.idTrangThaiThanhToan,
      this.idThoiGianLamViec,
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
      this.idThongSoKyThuat,
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
      this.diaChiCuThe,
      this.bangKhoiLuong
      });
  
  ///
  /// From JSON
  ///
  PreviewServiceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idNhomDichVu = json['idNhomDichVu'].toString();
    tieuDe = json['tieuDe'].toString();
    moTa = json['moTa'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    hinhAnhBanKhoiLuong = json['hinhAnhBanKhoiLuong'] as List<File>;
    hinhAnhBanVe = json['hinhAnhBanVe'].toString() as List<File>;
    idTrangThaiDonDichVu = json['idTrangThaiDonDichVu'].toString();
    idHinhThucThanhToan = json['idHinhThucThanhToan'].toString();
    idTrangThaiThanhToan = json['idTrangThaiThanhToan'].toString();
    idThoiGianLamViec = json['idThoiGianLamViec'].toString();
    idTinhTp = json['idTinhTp'].toString();
    idQuanHuyen = json['idQuanHuyen'].toString();
    idPhuongXa = json['idPhuongXa'].toString();
    giaTriKhachDeXuat = json['giaTriKhachDeXuat'].toString();
    hinhAnhChiTiet = json['hinhAnhChiTiet'].toString();
    moTaChiTiet = json['moTaChiTiet'].toString();
    file = json['file'] as File;
    soLuongYeuCau = json['soLuongYeuCau'].toString();
    soNgay = json['soNgay'].toString();
    diaDiemLamViec = json['diaDiemLamViec'].toString();
    idBangGiaDonHang = json['idBangGiaDonHang'].toString();
    gioiTinh = json['gioiTinh'].toString();
    idThongSoKyThuat = json['idThongSoKyThuat'].toString();
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
    bangKhoiLuong = json['bangKhoiLuong'] as List<VatTuResponse>;
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

    // check null hinhAnhBanKhoiLuong
    if (hinhAnhBanKhoiLuong != null) data['hinhAnhBanKhoiLuong'] = hinhAnhBanKhoiLuong; 

    // check null hinhAnhBanVe
    if (hinhAnhBanVe != null) data['hinhAnhBanVe'] = hinhAnhBanVe; 

    // check null idTrangThaiDonHang
    if (idTrangThaiDonDichVu != null) data['idTrangThaiDonHang'] = idTrangThaiDonDichVu; 

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null) data['idHinhThucThanhToan'] = idHinhThucThanhToan; 

    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null) data['idTrangThaiThanhToan'] = idTrangThaiThanhToan; 

    // check null idThoiGianLamViec
    if (idThoiGianLamViec != null) data['idThoiGianLamViec'] = idThoiGianLamViec; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null giaTriKhachDeXuat
    if (giaTriKhachDeXuat != null) data['giaTriKhachDeXuat'] = giaTriKhachDeXuat; 

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

    // check null idThongSoKyThuat
    if (idThongSoKyThuat != null) data['idThongSoKyThuat'] = idThongSoKyThuat; 

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
    if(diaChiCuThe != null) data['diaChiCuThe'] = diaChiCuThe;
    return data;
  }
}
