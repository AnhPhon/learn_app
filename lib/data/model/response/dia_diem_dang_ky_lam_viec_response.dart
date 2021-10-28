import 'dang_ky_viec_moi_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';

class DiaDiemDangKyLamViecResponse {
  String? id;
  DangKyViecMoiResponse? idDangKyViecMoi;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;

  String? createdAt;
  String? updatedAt;

  DiaDiemDangKyLamViecResponse({
      this.id,
      this.idDangKyViecMoi,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DiaDiemDangKyLamViecResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idDangKyViecMoi                                                              
    if (json['idDangKyViecMoi'] != null && json['idDangKyViecMoi'].toString().length!=24) {                                                  
      idDangKyViecMoi = DangKyViecMoiResponse.fromJson(json['idDangKyViecMoi'] as Map<String, dynamic>); 
    } else {                                                                           
      idDangKyViecMoi = null;                                                               
    }                                                                                  

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length!=24) {                                                  
      idTinhTp = TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null && json['idQuanHuyen'].toString().length!=24) {                                                  
      idQuanHuyen = QuanHuyenResponse.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null && json['idPhuongXa'].toString().length!=24) {                                                  
      idPhuongXa = PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  

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

    // check null idDangKyViecMoi
    if (idDangKyViecMoi != null) data['idDangKyViecMoi'] = idDangKyViecMoi; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 


    return data;
  }
}
