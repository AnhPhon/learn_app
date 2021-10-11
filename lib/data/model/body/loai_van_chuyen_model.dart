import 'tai_khoan_model.dart';

class LoaiVanChuyenModel {
  TaiKhoanModel? idTaiKhoan;
  String? tieuDe;

  LoaiVanChuyenModel({
      this.idTaiKhoan,
      this.tieuDe});
  
  ///
  /// From JSON
  ///
  LoaiVanChuyenModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['tieuDe'] = tieuDe;
    return data;
  }
}
