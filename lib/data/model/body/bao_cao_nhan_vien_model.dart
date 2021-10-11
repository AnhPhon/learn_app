import 'nhan_vien_model.dart';
import 'du_an_nhan_vien_model.dart';

class BaoCaoNhanVienModel {
  NhanVienModel? idNhanVien;
  DuAnNhanVienModel? idDuAnNhanVien;
  String? loai;
  String? soTuan;
  String? noiDung;

  BaoCaoNhanVienModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.loai,
      this.soTuan,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  BaoCaoNhanVienModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null) {                                                  
      idNhanVien = NhanVienModel.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null) {                                                  
      idDuAnNhanVien = DuAnNhanVienModel.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
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
