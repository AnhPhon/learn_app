import 'nhan_vien_model.dart';

class BangLuongModel {
  NhanVienModel? idNhanVien;
  String? file;

  BangLuongModel({
      this.idNhanVien,
      this.file});
  
  ///
  /// From JSON
  ///
  BangLuongModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null) {                                                  
      idNhanVien = NhanVienModel.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  
    file = json['file'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null file
    if (file != null) data['file'] = file; 


    return data;
  }
}
