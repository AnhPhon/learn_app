import 'tai_khoan_model.dart';

class TinHocModel {
  TaiKhoanModel? idTaiKhoan;
  String? word;
  String? excel;
  String? internet;
  String? phanMemHoTro;
  String? soThichTrinhDo;
  String? soThichKyNang;
  String? soTichTinhCach;

  TinHocModel({
      this.idTaiKhoan,
      this.word,
      this.excel,
      this.internet,
      this.phanMemHoTro,
      this.soThichTrinhDo,
      this.soThichKyNang,
      this.soTichTinhCach});
  
  ///
  /// From JSON
  ///
  TinHocModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    word = json['word'].toString();
    excel = json['excel'].toString();
    internet = json['internet'].toString();
    phanMemHoTro = json['phanMemHoTro'].toString();
    soThichTrinhDo = json['soThichTrinhDo'].toString();
    soThichKyNang = json['soThichKyNang'].toString();
    soTichTinhCach = json['soTichTinhCach'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null word
    if (word != null) data['word'] = word; 

    // check null excel
    if (excel != null) data['excel'] = excel; 

    // check null internet
    if (internet != null) data['internet'] = internet; 

    // check null phanMemHoTro
    if (phanMemHoTro != null) data['phanMemHoTro'] = phanMemHoTro; 

    // check null soThichTrinhDo
    if (soThichTrinhDo != null) data['soThichTrinhDo'] = soThichTrinhDo; 

    // check null soThichKyNang
    if (soThichKyNang != null) data['soThichKyNang'] = soThichKyNang; 

    // check null soTichTinhCach
    if (soTichTinhCach != null) data['soTichTinhCach'] = soTichTinhCach; 


    return data;
  }
}
