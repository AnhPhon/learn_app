import 'tuyen_dung_response.dart';

class DanhSachUngTuyenResponse {
  String? id;
  TuyenDungResponse? idTuyenDung;
  String? taiKhoanUngTuyen;
  String? daXem;

  String? createdAt;
  String? updatedAt;

  DanhSachUngTuyenResponse({
      this.id,
      this.idTuyenDung,
      this.taiKhoanUngTuyen,
      this.daXem,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DanhSachUngTuyenResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null && json['idTuyenDung'].toString().length!=24) {                                                  
      idTuyenDung = TuyenDungResponse.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
    }                                                                                  
    taiKhoanUngTuyen = json['taiKhoanUngTuyen'].toString();
    daXem = json['daXem'].toString();

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

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null taiKhoanUngTuyen
    if (taiKhoanUngTuyen != null) data['taiKhoanUngTuyen'] = taiKhoanUngTuyen; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
