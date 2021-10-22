import 'tai_khoan_response.dart';
import 'vi_tien_response.dart';

class LichSuViTienResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  ViTienResponse? idViTien;
  String? loaiGiaoDich;
  String? soTien;
  String? noiDung;
  String? trangThai;
  String? hinhAnhHoaDon;

  String? createdAt;
  String? updatedAt;

  LichSuViTienResponse({
      this.id,
      this.idTaiKhoan,
      this.idViTien,
      this.loaiGiaoDich,
      this.soTien,
      this.noiDung,
      this.trangThai,
      this.hinhAnhHoaDon,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  LichSuViTienResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();                                                                               

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idViTien                                                              
    if (json['idViTien'] != null && json['idViTien'].toString().length!=24) {                                                  
      idViTien = ViTienResponse.fromJson(json['idViTien'] as Map<String, dynamic>); 
    } else {                                                                           
      idViTien = null;                                                               
    }                                                                                  
    loaiGiaoDich = json['loaiGiaoDich'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();
    trangThai = json['trangThai'].toString();
    hinhAnhHoaDon = json['hinhAnhHoaDon'].toString();

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

    // check null idViTien
    if (idViTien != null) data['idViTien'] = idViTien; 

    // check null loaiGiaoDich
    if (loaiGiaoDich != null) data['loaiGiaoDich'] = loaiGiaoDich; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 

    // check null hinhAnhHoaDon
    if (hinhAnhHoaDon != null) data['hinhAnhHoaDon'] = hinhAnhHoaDon; 


    return data;
  }
}
