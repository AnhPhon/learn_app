import 'tai_khoan_model.dart';
import 'don_dich_vu_model.dart';
import 'tuyen_dung_model.dart';

class LichSuGiaoDichModel {
  TaiKhoanModel? idTaiKhoan;
  String? taiKhoanNhanDon;
  DonDichVuModel? idDonDichVu;
  TuyenDungModel? idTuyenDung;
  String? soTien;
  String? hinhAnhGiaoDich;
  String? trangThai;

  LichSuGiaoDichModel({
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.idDonDichVu,
      this.idTuyenDung,
      this.soTien,
      this.hinhAnhGiaoDich,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  LichSuGiaoDichModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null) {                                                  
      idDonDichVu = DonDichVuModel.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null) {                                                  
      idTuyenDung = TuyenDungModel.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
    }                                                                                  
    soTien = json['soTien'].toString();
    hinhAnhGiaoDich = json['hinhAnhGiaoDich'].toString();
    trangThai = json['trangThai'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null hinhAnhGiaoDich
    if (hinhAnhGiaoDich != null) data['hinhAnhGiaoDich'] = hinhAnhGiaoDich; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
