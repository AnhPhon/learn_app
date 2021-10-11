import 'tuyen_dung_model.dart';

class DanhSachUngTuyenModel {
  TuyenDungModel? idTuyenDung;
  String? taiKhoanUngTuyen;
  String? daXem;

  DanhSachUngTuyenModel({
      this.idTuyenDung,
      this.taiKhoanUngTuyen,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachUngTuyenModel.fromJson(Map<String, dynamic> json) {

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null) {                                                  
      idTuyenDung = TuyenDungModel.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
    }                                                                                  
    taiKhoanUngTuyen = json['taiKhoanUngTuyen'].toString();
    daXem = json['daXem'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null taiKhoanUngTuyen
    if (taiKhoanUngTuyen != null) data['taiKhoanUngTuyen'] = taiKhoanUngTuyen; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}
