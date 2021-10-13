import 'nhan_vien_response.dart';

class BangLuongResponse {
  String? id;
  NhanVienResponse? idNhanVien;
  String? file;

  String? createdAt;
  String? updatedAt;

  BangLuongResponse({
      this.id,
      this.idNhanVien,
      this.file,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  BangLuongResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null && json['idNhanVien'].toString().length!=24) {                                                  
      idNhanVien = NhanVienResponse.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  
    file = json['file'].toString();

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

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null file
    if (file != null) data['file'] = file; 


    return data;
  }
}
