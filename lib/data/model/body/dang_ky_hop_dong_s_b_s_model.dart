import 'tai_khoan_model.dart';

class DangKyHopDongSBSModel {
  TaiKhoanModel? idTaiKhoan;
  String? file;
  String? trangThai;

  DangKyHopDongSBSModel({
      this.idTaiKhoan,
      this.file,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  DangKyHopDongSBSModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
