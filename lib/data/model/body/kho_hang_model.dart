import 'du_an_nhan_vien_model.dart';

class KhoHangModel {
  DuAnNhanVienModel? idDuAnNhanVien;
  String? tenKho;

  KhoHangModel({
      this.idDuAnNhanVien,
      this.tenKho});
  
  ///
  /// From JSON
  ///
  KhoHangModel.fromJson(Map<String, dynamic> json) {

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null && json['idDuAnNhanVien'].toString().length != 24) {                                                  
      idDuAnNhanVien = DuAnNhanVienModel.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
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
    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null tenKho
    if (tenKho != null) data['tenKho'] = tenKho; 


    return data;
  }
}
