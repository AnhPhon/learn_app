import 'tai_khoan_response.dart';

class NgoaiNguResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? loaiNgoaiNgu;
  String? trinhDo;
  String? nghe;
  String? noi;
  String? doc;
  String? viet;

  String? createdAt;
  String? updatedAt;

  NgoaiNguResponse({
      this.id,
      this.idTaiKhoan,
      this.loaiNgoaiNgu,
      this.trinhDo,
      this.nghe,
      this.noi,
      this.doc,
      this.viet,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  NgoaiNguResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    loaiNgoaiNgu = json['loaiNgoaiNgu'].toString();
    trinhDo = json['trinhDo'].toString();
    nghe = json['nghe'].toString();
    noi = json['noi'].toString();
    doc = json['doc'].toString();
    viet = json['viet'].toString();

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

    // check null loaiNgoaiNgu
    if (loaiNgoaiNgu != null) data['loaiNgoaiNgu'] = loaiNgoaiNgu; 

    // check null trinhDo
    if (trinhDo != null) data['trinhDo'] = trinhDo; 

    // check null nghe
    if (nghe != null) data['nghe'] = nghe; 

    // check null noi
    if (noi != null) data['noi'] = noi; 

    // check null doc
    if (doc != null) data['doc'] = doc; 

    // check null viet
    if (viet != null) data['viet'] = viet; 


    return data;
  }
}
