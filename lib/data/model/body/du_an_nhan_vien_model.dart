import 'phuong_xa_model.dart';
import 'quan_huyen_model.dart';
import 'tinh_tp_model.dart';

class DuAnNhanVienModel {
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? tieuDe;
  String? diaChi;
  String? moTa;

  DuAnNhanVienModel({
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.tieuDe,
      this.diaChi,
      this.moTa});
  
  ///
  /// From JSON
  ///
  DuAnNhanVienModel.fromJson(Map<String, dynamic> json) {

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null) {                                                  
      idTinhTp = TinhTpModel.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null) {                                                  
      idQuanHuyen = QuanHuyenModel.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null) {                                                  
      idPhuongXa = PhuongXaModel.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    diaChi = json['diaChi'].toString();
    moTa = json['moTa'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['tieuDe'] = tieuDe;
    data['diaChi'] = diaChi;
    data['moTa'] = moTa;
    return data;
  }
}
