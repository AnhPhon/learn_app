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
    if (json['idDuAnNhanVien'] != null) {                                                  
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
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['tenKho'] = tenKho;
    return data;
  }
}
