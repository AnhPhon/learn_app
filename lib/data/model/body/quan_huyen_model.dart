import 'tinh_tp_model.dart';

class QuanHuyenModel {
  TinhTpModel? idTinhTp;
  String? ten;

  QuanHuyenModel({
      this.idTinhTp,
      this.ten});
  
  ///
  /// From JSON
  ///
  QuanHuyenModel.fromJson(Map<String, dynamic> json) {

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null) {                                                  
      idTinhTp = TinhTpModel.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  
    ten = json['ten'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTinhTp'] = idTinhTp;
    data['ten'] = ten;
    return data;
  }
}
