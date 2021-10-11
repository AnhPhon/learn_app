import 'hinh_thuc_thanh_toan_model.dart';
import 'phuong_xa_model.dart';
import 'quan_huyen_model.dart';
import 'tai_khoan_model.dart';
import 'tinh_tp_model.dart';
import 'trang_thai_don_hang_model.dart';

class DonHangModel {
  TaiKhoanModel? idTaiKhoan;
  String? taiKhoanMuaHang;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? diaChi;
  String? phiVanChuyen;
  String? khuyenMai;
  String? phiDichVu;
  String? soTien;
  String? tongTien;
  TrangThaiDonHangModel? idTrangThaiDonHang;
  HinhThucThanhToanModel? idHinhThucThanhToan;

  DonHangModel({
      this.idTaiKhoan,
      this.taiKhoanMuaHang,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.phiVanChuyen,
      this.khuyenMai,
      this.phiDichVu,
      this.soTien,
      this.tongTien,
      this.idTrangThaiDonHang,
      this.idHinhThucThanhToan});
  
  ///
  /// From JSON
  ///
  DonHangModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanMuaHang = json['taiKhoanMuaHang'].toString();

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null) {                                                  
      idTinhTp = TinhTpModel.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null) {                                                  
      idQuanHuyen = QuanHuyenModel.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null) {                                                  
      idPhuongXa = PhuongXaModel.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    diaChi = json['diaChi'].toString();
    phiVanChuyen = json['phiVanChuyen'].toString();
    khuyenMai = json['khuyenMai'].toString();
    phiDichVu = json['phiDichVu'].toString();
    soTien = json['soTien'].toString();
    tongTien = json['tongTien'].toString();

    // mapping idTrangThaiDonHang                                                              
    if (json['idTrangThaiDonHang'] != null) {                                                  
      idTrangThaiDonHang = TrangThaiDonHangModel.fromJson(json['idTrangThaiDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiDonHang = null;                                                               
    }                                                                                  

    // mapping idHinhThucThanhToan                                                              
    if (json['idHinhThucThanhToan'] != null) {                                                  
      idHinhThucThanhToan = HinhThucThanhToanModel.fromJson(json['idHinhThucThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idHinhThucThanhToan = null;                                                               
    }                                                                                  

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanMuaHang'] = taiKhoanMuaHang;
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['diaChi'] = diaChi;
    data['phiVanChuyen'] = phiVanChuyen;
    data['khuyenMai'] = khuyenMai;
    data['phiDichVu'] = phiDichVu;
    data['soTien'] = soTien;
    data['tongTien'] = tongTien;
    data['idTrangThaiDonHang'] = idTrangThaiDonHang;
    data['idHinhThucThanhToan'] = idHinhThucThanhToan;
    return data;
  }
}
