import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';

class DanhSachThoThauBaoGiaRequest {
  String? id;
  String? idDuAnKhachHang;
  String? taiKhoanBaoGia;
  String? idTrangThaiBaoGia;
  String? thoiGianHoanThanh;
  String? giaBao;
  String? ghiChu;
  String? tienCoc;
  String? daXem;

  // For thothau
  String? idNhomDichVu;
  List<String>? idLoaiCongViecs;
  String? thoiGianBatDauLam;
  int? soLuongNguoi;

  // For daily
  String? idNhomCuaHang;
  List<String>? idMatHangDacTrungs;
  String? noiDungMoTa;

  DanhSachThoThauBaoGiaRequest({
    this.id,
    this.idDuAnKhachHang,
    this.taiKhoanBaoGia,
    this.idTrangThaiBaoGia,
    this.thoiGianHoanThanh,
    this.giaBao,
    this.ghiChu,
    this.tienCoc,
    this.daXem,
    this.idNhomDichVu,
    this.idLoaiCongViecs,
    this.thoiGianBatDauLam,
    this.soLuongNguoi,
    this.idNhomCuaHang,
    this.idMatHangDacTrungs,
    this.noiDungMoTa,
  });

  ///
  /// From JSON
  ///
  DanhSachThoThauBaoGiaRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDuAnKhachHang = json['idDuAnKhachHang'].toString();
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    idTrangThaiBaoGia = json['idTrangThaiBaoGia'].toString();
    thoiGianHoanThanh = json['thoiGianHoanThanh'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    tienCoc = json['tienCoc'].toString();
    daXem = json['daXem'].toString();

    idNhomDichVu = json['idNhomDichVu'].toString();
    idLoaiCongViecs = [];
    if(json['idLoaiCongViecs'] != null){
      json['idLoaiCongViecs'].map((e) => idLoaiCongViecs!.add(e.toString()));
    }
    if(json['thoiGianBatDauLam'] != null) thoiGianBatDauLam = json['thoiGianBatDauLam'].toString();
    if(json['soLuongNguoi'] != null) soLuongNguoi = int.parse(json['soLuongNguoi'].toString());

    idNhomCuaHang = json['idNhomCuaHang'].toString();
    idMatHangDacTrungs = [];
    if(json['idMatHangDacTrungs'] != null){
      json['idMatHangDacTrungs'].map((e) => idMatHangDacTrungs!.add(e.toString()));
    }
    noiDungMoTa = json['noiDungMoTa'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    // if (id != null) data['id'] = id;

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang;

    // check null taiKhoanBaoGia
    if (taiKhoanBaoGia != null) data['taiKhoanBaoGia'] = taiKhoanBaoGia;

    // check null idTrangThaiBaoGia
    // if (idTrangThaiBaoGia != null) data['idTrangThaiBaoGia'] = idTrangThaiBaoGia;

    // check null thoiGianHoanThanh
    if (thoiGianHoanThanh != null) data['thoiGianHoanThanh'] = thoiGianHoanThanh;

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao;

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu;

    // check null tienCoc
    if (tienCoc != null) data['tienCoc'] = tienCoc;

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    // check null daXem
    if (idLoaiCongViecs != null) data['idLoaiCongViecs'] = idLoaiCongViecs;

    // check null daXem
    if (thoiGianBatDauLam != null) data['thoiGianBatDauLam'] = thoiGianBatDauLam.toString();

    // check null daXem
    if (soLuongNguoi != null) data['soLuongNguoi'] = soLuongNguoi;

    // check null daXem
    if (idNhomCuaHang != null) data['idNhomCuaHang'] = idNhomCuaHang;

    // check null daXem
    if (idMatHangDacTrungs != null) data['idMatHangDacTrungs'] = idMatHangDacTrungs;

    // check null daXem
    if (noiDungMoTa != null) data['noiDungMoTa'] = noiDungMoTa;

    return data;
  }
}
