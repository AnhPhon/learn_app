import 'tai_khoan_response.dart';

class ViTienResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? tongTien;
  String? trangThai;

  String? createdAt;
  String? updatedAt;

  ViTienResponse({
      this.id,
      this.idTaiKhoan,
      this.tongTien,
      this.trangThai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ViTienResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    tongTien = json['tongTien'].toString();
    trangThai = json['trangThai'].toString();

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

    // check null tongTien
    if (tongTien != null) data['tongTien'] = tongTien; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
