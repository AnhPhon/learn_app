import 'quan_huyen_model.dart';

class PhuongXaModel {
  QuanHuyenModel? idQuanHuyen;
  String? ten;

  PhuongXaModel({
      this.idQuanHuyen,
      this.ten});
  
  ///
  /// From JSON
  ///
  PhuongXaModel.fromJson(Map<String, dynamic> json) {

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null) {                                                  
      idQuanHuyen = QuanHuyenModel.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  
    ten = json['ten'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }
}
