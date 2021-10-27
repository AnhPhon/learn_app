import 'tai_khoan_response.dart';
import 'tuyen_dung_response.dart';

class DanhSachLuuTinTuyenDungResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  TuyenDungResponse? idTuyenDung;

  String? createdAt;
  String? updatedAt;

  DanhSachLuuTinTuyenDungResponse({
      this.id,
      this.idTaiKhoan,
      this.idTuyenDung,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DanhSachLuuTinTuyenDungResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null && json['idTuyenDung'].toString().length!=24) {                                                  
      idTuyenDung = TuyenDungResponse.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
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

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 


    return data;
  }
}
