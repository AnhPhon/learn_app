import 'nhan_vien_model.dart';
import 'du_an_nhan_vien_model.dart';
import 'kho_hang_model.dart';
import 'vat_tu_model.dart';
import 'don_vi_cung_cap_model.dart';

class XuatNhapKhoModel {
  NhanVienModel? idNhanVien;
  DuAnNhanVienModel? idDuAnNhanVien;
  KhoHangModel? idKhoHang;
  VatTuModel? idVatTu;
  DonViCungCapModel? idDonViCungCap;
  String? soLuong;
  String? ghiChu;

  XuatNhapKhoModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.idKhoHang,
      this.idVatTu,
      this.idDonViCungCap,
      this.soLuong,
      this.ghiChu});
  
  ///
  /// From JSON
  ///
  XuatNhapKhoModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null) {                                                  
      idNhanVien = NhanVienModel.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null) {                                                  
      idDuAnNhanVien = DuAnNhanVienModel.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  

    // mapping idKhoHang                                                              
    if (json['idKhoHang'] != null) {                                                  
      idKhoHang = KhoHangModel.fromJson(json['idKhoHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idKhoHang = null;                                                               
    }                                                                                  

    // mapping idVatTu                                                              
    if (json['idVatTu'] != null) {                                                  
      idVatTu = VatTuModel.fromJson(json['idVatTu'] as Map<String, dynamic>); 
    } else {                                                                           
      idVatTu = null;                                                               
    }                                                                                  

    // mapping idDonViCungCap                                                              
    if (json['idDonViCungCap'] != null) {                                                  
      idDonViCungCap = DonViCungCapModel.fromJson(json['idDonViCungCap'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonViCungCap = null;                                                               
    }                                                                                  
    soLuong = json['soLuong'].toString();
    ghiChu = json['ghiChu'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null idKhoHang
    if (idKhoHang != null) data['idKhoHang'] = idKhoHang; 

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu; 

    // check null idDonViCungCap
    if (idDonViCungCap != null) data['idDonViCungCap'] = idDonViCungCap; 

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong; 

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu; 


    return data;
  }
}
