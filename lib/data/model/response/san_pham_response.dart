import 'tai_khoan_response.dart';
import 'danh_muc_san_pham_response.dart';
import 'bang_gia_phi_van_chuyen_response.dart';

class SanPhamResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  DanhMucSanPhamResponse? idDanhMucSanPham;
  String? ten;
  String? thuongHieu;
  String? moTa;
  String? hinhAnhDaiDien;
  String? hinhAnhSanPham;
  String? quyCach;
  String? gia;
  String? maSanPham;
  String? kieuVanChuyen;
  BangGiaPhiVanChuyenResponse? idBangGiaPhiVanChuyen;

  SanPhamResponse({
      this.id,
      this.idTaiKhoan,
      this.idDanhMucSanPham,
      this.ten,
      this.thuongHieu,
      this.moTa,
      this.hinhAnhDaiDien,
      this.hinhAnhSanPham,
      this.quyCach,
      this.gia,
      this.maSanPham,
      this.kieuVanChuyen,
      this.idBangGiaPhiVanChuyen});
  
  ///
  /// From JSON
  ///
  SanPhamResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idDanhMucSanPham                                                              
    if (json['idDanhMucSanPham'] != null && json['idDanhMucSanPham'].toString().length!=24) {                                                  
      idDanhMucSanPham = DanhMucSanPhamResponse.fromJson(json['idDanhMucSanPham'] as Map<String, dynamic>); 
    } else {                                                                           
      idDanhMucSanPham = null;                                                               
    }                                                                                  
    ten = json['ten'].toString();
    thuongHieu = json['thuongHieu'].toString();
    moTa = json['moTa'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    hinhAnhSanPham = json['hinhAnhSanPham'].toString();
    quyCach = json['quyCach'].toString();
    gia = json['gia'].toString();
    maSanPham = json['maSanPham'].toString();
    kieuVanChuyen = json['kieuVanChuyen'].toString();

    // mapping idBangGiaPhiVanChuyen                                                              
    if (json['idBangGiaPhiVanChuyen'] != null && json['idBangGiaPhiVanChuyen'].toString().length!=24) {                                                  
      idBangGiaPhiVanChuyen = BangGiaPhiVanChuyenResponse.fromJson(json['idBangGiaPhiVanChuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangGiaPhiVanChuyen = null;                                                               
    }                                                                                  

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

    // check null idDanhMucSanPham
    if (idDanhMucSanPham != null) data['idDanhMucSanPham'] = idDanhMucSanPham; 

    // check null ten
    if (ten != null) data['ten'] = ten; 

    // check null thuongHieu
    if (thuongHieu != null) data['thuongHieu'] = thuongHieu; 

    // check null moTa
    if (moTa != null) data['moTa'] = moTa; 

    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien; 

    // check null hinhAnhSanPham
    if (hinhAnhSanPham != null) data['hinhAnhSanPham'] = hinhAnhSanPham; 

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach; 

    // check null gia
    if (gia != null) data['gia'] = gia; 

    // check null maSanPham
    if (maSanPham != null) data['maSanPham'] = maSanPham; 

    // check null kieuVanChuyen
    if (kieuVanChuyen != null) data['kieuVanChuyen'] = kieuVanChuyen; 

    // check null idBangGiaPhiVanChuyen
    if (idBangGiaPhiVanChuyen != null) data['idBangGiaPhiVanChuyen'] = idBangGiaPhiVanChuyen; 


    return data;
  }
}
