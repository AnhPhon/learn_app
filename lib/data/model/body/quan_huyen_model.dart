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
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length != 24) {                                                  
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
    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null ten
    if (ten != null) data['ten'] = ten; 


    return data;
  }

  @override
  String toString() {
    return ten!;
  }

}
