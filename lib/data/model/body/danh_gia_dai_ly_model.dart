import 'tai_khoan_model.dart';

class DanhGiaDaiLyModel {
  TaiKhoanModel? idTaiKhoan;
  String? taiKhoanDanhGia;
  String? diemDanhGia;
  String? tieuDe;
  String? noiDung;

  DanhGiaDaiLyModel({
      this.idTaiKhoan,
      this.taiKhoanDanhGia,
      this.diemDanhGia,
      this.tieuDe,
      this.noiDung});
  
  ///
  /// From JSON
  ///
  DanhGiaDaiLyModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanDanhGia = json['taiKhoanDanhGia'].toString();
    diemDanhGia = json['diemDanhGia'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanDanhGia
    if (taiKhoanDanhGia != null) data['taiKhoanDanhGia'] = taiKhoanDanhGia; 

    // check null diemDanhGia
    if (diemDanhGia != null) data['diemDanhGia'] = diemDanhGia; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 


    return data;
  }
}
