import 'tai_khoan_response.dart';

class TinHocResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? word;
  String? excel;
  String? internet;
  String? phanMemHoTro;
  String? soThichTrinhDo;
  String? soThichKyNang;
  String? soTichTinhCach;

  String? createdAt;
  String? updatedAt;

  TinHocResponse({
      this.id,
      this.idTaiKhoan,
      this.word,
      this.excel,
      this.internet,
      this.phanMemHoTro,
      this.soThichTrinhDo,
      this.soThichKyNang,
      this.soTichTinhCach,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  TinHocResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
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
