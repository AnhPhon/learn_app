import 'du_an_nhan_vien_response.dart';

class KhoHangResponse {
  String? id;
  DuAnNhanVienResponse? idDuAnNhanVien;
  String? tenKho;

  KhoHangResponse({
      this.id,
      this.idDuAnNhanVien,
      this.tenKho});
  
  ///
  /// From JSON
  ///
  KhoHangResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null && json['idDuAnNhanVien'].toString().length!=24) {                                                  
      idDuAnNhanVien = DuAnNhanVienResponse.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  
    tenKho = json['tenKho'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null tenKho
    if (tenKho != null) data['tenKho'] = tenKho; 


    return data;
  }
}
