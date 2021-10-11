import 'tai_khoan_model.dart';

class NgoaiNguModel {
  TaiKhoanModel? idTaiKhoan;
  String? loaiNgoaiNgu;
  String? trinhDo;
  String? nghe;
  String? noi;
  String? doc;
  String? viet;

  NgoaiNguModel({
      this.idTaiKhoan,
      this.loaiNgoaiNgu,
      this.trinhDo,
      this.nghe,
      this.noi,
      this.doc,
      this.viet});
  
  ///
  /// From JSON
  ///
  NgoaiNguModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    loaiNgoaiNgu = json['loaiNgoaiNgu'].toString();
    trinhDo = json['trinhDo'].toString();
    nghe = json['nghe'].toString();
    noi = json['noi'].toString();
    doc = json['doc'].toString();
    viet = json['viet'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
