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
    data['idTaiKhoan'] = idTaiKhoan;
    data['loaiNgoaiNgu'] = loaiNgoaiNgu;
    data['trinhDo'] = trinhDo;
    data['nghe'] = nghe;
    data['noi'] = noi;
    data['doc'] = doc;
    data['viet'] = viet;
    return data;
  }
}
