import 'package:template/data/model/response/trang_thai_thanh_toan_response.dart';

import 'tai_khoan_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'trang_thai_don_hang_response.dart';
import 'hinh_thuc_thanh_toan_response.dart';

class DonHangResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? taiKhoanMuaHang;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? diaChi;
  String? phiVanChuyen;
  String? khuyenMai;
  String? phiDichVu;
  String? soTien;
  String? tongTien;
  String? hinhAnh;
  TrangThaiDonHangResponse? idTrangThaiDonHang;
  TrangThaiThanhToanResponse? idTrangThaiThanhToan;
  HinhThucThanhToanResponse? idHinhThucThanhToan;

  String? createdAt;
  String? updatedAt;

  DonHangResponse({
      this.id,
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
      this.hinhAnh,
      this.idTrangThaiDonHang,
      this.idTrangThaiThanhToan,
      this.idHinhThucThanhToan,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DonHangResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanMuaHang = json['taiKhoanMuaHang'].toString();

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length!=24) {                                                  
      idTinhTp = TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null && json['idQuanHuyen'].toString().length!=24) {                                                  
      idQuanHuyen = QuanHuyenResponse.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null && json['idPhuongXa'].toString().length!=24) {                                                  
      idPhuongXa = PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    diaChi = json['diaChi'].toString();
    phiVanChuyen = json['phiVanChuyen'].toString();
    khuyenMai = json['khuyenMai'].toString();
    phiDichVu = json['phiDichVu'].toString();
    soTien = json['soTien'].toString();
    tongTien = json['tongTien'].toString();
    hinhAnh = json['hinhAnh'].toString();

    // mapping idTrangThaiDonHang                                                              
    if (json['idTrangThaiDonHang'] != null && json['idTrangThaiDonHang'].toString().length!=24) {                                                  
      idTrangThaiDonHang = TrangThaiDonHangResponse.fromJson(json['idTrangThaiDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiDonHang = null;                                                               
    }    

    // mapping idTrangThaiThanhToan                                                              
    if (json['idTrangThaiThanhToan'] != null && json['idTrangThaiThanhToan'].toString().length!=24) {                                                  
      idTrangThaiThanhToan = TrangThaiThanhToanResponse.fromJson(json['idTrangThaiThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiThanhToan = null;                                                               
    }                                                                                  

    // mapping idHinhThucThanhToan                                                              
    if (json['idHinhThucThanhToan'] != null && json['idHinhThucThanhToan'].toString().length!=24) {                                                  
      idHinhThucThanhToan = HinhThucThanhToanResponse.fromJson(json['idHinhThucThanhToan'] as Map<String, dynamic>); 
    } else {                                                                           
      idHinhThucThanhToan = null;                                                               
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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanMuaHang
    if (taiKhoanMuaHang != null) data['taiKhoanMuaHang'] = taiKhoanMuaHang; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null phiVanChuyen
    if (phiVanChuyen != null) data['phiVanChuyen'] = phiVanChuyen; 

    // check null khuyenMai
    if (khuyenMai != null) data['khuyenMai'] = khuyenMai; 

    // check null phiDichVu
    if (phiDichVu != null) data['phiDichVu'] = phiDichVu; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null tongTien
    if (tongTien != null) data['tongTien'] = tongTien; 

    // check null hinhAnh
    if (hinhAnh != null) data['hinhAnh'] = hinhAnh; 

    // check null idTrangThaiDonHang
    if (idTrangThaiDonHang != null) data['idTrangThaiDonHang'] = idTrangThaiDonHang; 

    // check null idTrangThaiThanhToan
    if (idTrangThaiThanhToan != null) data['idTrangThaiThanhToan'] = idTrangThaiThanhToan; 

    // check null idHinhThucThanhToan
    if (idHinhThucThanhToan != null) data['idHinhThucThanhToan'] = idHinhThucThanhToan; 


    return data;
  }
}
