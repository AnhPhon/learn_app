import 'tai_khoan_response.dart';

class DanhGiaDaiLyResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? taiKhoanDanhGia;
  String? diemDanhGia;
  String? tieuDe;
  String? noiDung;

  String? createdAt;
  String? updatedAt;

  DanhGiaDaiLyResponse({
      this.id,
      this.idTaiKhoan,
      this.taiKhoanDanhGia,
      this.diemDanhGia,
      this.tieuDe,
      this.noiDung,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  DanhGiaDaiLyResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanDanhGia = json['taiKhoanDanhGia'].toString();
    diemDanhGia = json['diemDanhGia'].toString();
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();

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
