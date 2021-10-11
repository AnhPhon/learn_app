import 'nhan_vien_model.dart';

class ThuChiNhanVienModel {
  NhanVienModel? idNhanVien;
  String? loai;
  String? tieuDe;
  String? soTien;
  String? noiDung;

  ThuChiNhanVienModel({
      this.idNhanVien,
      this.loai,
      this.tieuDe,
      this.soTien,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  ThuChiNhanVienModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null) {                                                  
      idNhanVien = NhanVienModel.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['loai'] = loai;
    data['tieuDe'] = tieuDe;
    data['soTien'] = soTien;
    data['noiDung'] = noiDung;
    return data;
  }
}
