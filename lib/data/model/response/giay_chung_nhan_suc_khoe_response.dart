import 'tai_khoan_response.dart';

class GiayChungNhanSucKhoeResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? file;
  String? trangThai;

  String? createdAt;
  String? updatedAt;

  GiayChungNhanSucKhoeResponse({
      this.id,
      this.idTaiKhoan,
      this.file,
      this.trangThai,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  GiayChungNhanSucKhoeResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    file = json['file'].toString();
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

    // check null file
    if (file != null) data['file'] = file; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 


    return data;
  }
}
