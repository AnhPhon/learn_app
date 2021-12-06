import 'tai_khoan_response.dart';

class LienHeRiengResponse {
  String? id;
  String? ngayGiaoDich;
  String? giaTriGiaoDich;
  String? noiDung;
  TaiKhoanResponse? idTaiKhoan;
  TaiKhoanResponse? idTaiKhoanLienHe;

  String? createdAt;
  String? updatedAt;

  LienHeRiengResponse({
      this.id,
      this.ngayGiaoDich,
      this.giaTriGiaoDich,
      this.noiDung,
      this.idTaiKhoan,
      this.idTaiKhoanLienHe,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  LienHeRiengResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    ngayGiaoDich = json['ngayGiaoDich'].toString();
    giaTriGiaoDich = json['giaTriGiaoDich'].toString();
    noiDung = json['noiDung'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    } 

    // mapping idTaiKhoanLienHe                                                              
    if (json['idTaiKhoanLienHe'] != null && json['idTaiKhoanLienHe'].toString().length!=24) {                                                  
      idTaiKhoanLienHe = TaiKhoanResponse.fromJson(json['idTaiKhoanLienHe'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoanLienHe = null;                                                               
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

    // check null ngayGiaoDich
    if (ngayGiaoDich != null) data['ngayGiaoDich'] = ngayGiaoDich; 

    // check null giaTriGiaoDich
    if (giaTriGiaoDich != null) data['giaTriGiaoDich'] = giaTriGiaoDich; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null idTaiKhoanLienHe
    if (idTaiKhoanLienHe != null) data['idTaiKhoanLienHe'] = idTaiKhoanLienHe; 


    return data;
  }
}
