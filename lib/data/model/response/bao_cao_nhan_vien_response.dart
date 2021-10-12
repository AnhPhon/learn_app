import 'nhan_vien_response.dart';
import 'du_an_nhan_vien_response.dart';

class BaoCaoNhanVienResponse {
  String? id;
  NhanVienResponse? idNhanVien;
  DuAnNhanVienResponse? idDuAnNhanVien;
  String? loai;
  String? soTuan;
  String? noiDung;

  BaoCaoNhanVienResponse({
      this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.loai,
      this.soTuan,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  BaoCaoNhanVienResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null && json['idNhanVien'].toString().length!=24) {                                                  
      idNhanVien = NhanVienResponse.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null && json['idDuAnNhanVien'].toString().length!=24) {                                                  
      idDuAnNhanVien = DuAnNhanVienResponse.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  
    loai = json['loai'].toString();
    soTuan = json['soTuan'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null loai
    if (loai != null) data['loai'] = loai; 

    // check null soTuan
    if (soTuan != null) data['soTuan'] = soTuan; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
