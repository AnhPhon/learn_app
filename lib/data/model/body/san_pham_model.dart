import 'bang_gia_phi_van_chuyen_model.dart';
import 'danh_muc_san_pham_model.dart';
import 'tai_khoan_model.dart';

class SanPhamModel {
  TaiKhoanModel? idTaiKhoan;
  DanhMucSanPhamModel? idDanhMucSanPham;
  String? ten;
  String? thuongHieu;
  String? moTa;
  String? hinhAnhDaiDien;
  String? hinhAnhSanPham;
  String? quyCach;
  String? gia;
  String? maSanPham;
  String? kieuVanChuyen;
  BangGiaPhiVanChuyenModel? idBangGiaPhiVanChuyen;

  SanPhamModel({
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
  SanPhamModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idDanhMucSanPham                                                              
    if (json['idDanhMucSanPham'] != null) {                                                  
      idDanhMucSanPham = DanhMucSanPhamModel.fromJson(json['idDanhMucSanPham'] as Map<String, dynamic>); 
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
    if (json['idBangGiaPhiVanChuyen'] != null) {                                                  
      idBangGiaPhiVanChuyen = BangGiaPhiVanChuyenModel.fromJson(json['idBangGiaPhiVanChuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idBangGiaPhiVanChuyen = null;                                                               
    }                                                                                  

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['idDanhMucSanPham'] = idDanhMucSanPham;
    data['ten'] = ten;
    data['thuongHieu'] = thuongHieu;
    data['moTa'] = moTa;
    data['hinhAnhDaiDien'] = hinhAnhDaiDien;
    data['hinhAnhSanPham'] = hinhAnhSanPham;
    data['quyCach'] = quyCach;
    data['gia'] = gia;
    data['maSanPham'] = maSanPham;
    data['kieuVanChuyen'] = kieuVanChuyen;
    data['idBangGiaPhiVanChuyen'] = idBangGiaPhiVanChuyen;
    return data;
  }
}
