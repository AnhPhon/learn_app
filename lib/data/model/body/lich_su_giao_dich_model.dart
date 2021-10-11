import 'don_dich_vu_model.dart';
import 'tai_khoan_model.dart';
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
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['idDonDichVu'] = idDonDichVu;
    data['idTuyenDung'] = idTuyenDung;
    data['soTien'] = soTien;
    data['hinhAnhGiaoDich'] = hinhAnhGiaoDich;
    data['trangThai'] = trangThai;
    return data;
  }
}
