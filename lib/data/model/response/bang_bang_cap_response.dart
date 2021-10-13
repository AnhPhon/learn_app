import 'tai_khoan_response.dart';
import 'trinh_do_response.dart';
import 'chuyen_mon_response.dart';
import 'loai_tot_nghiep_response.dart';

class BangBangCapResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  TrinhDoResponse? idTrinhDo;
  ChuyenMonResponse? idChuyenMon;
  LoaiTotNghiepResponse? idLoaiTotNghiep;
  String? namTotNghiep;
  String? donViDaoTao;
  String? anhBangCap;

  String? createdAt;
  String? updatedAt;

  BangBangCapResponse({
      this.id,
      this.idTaiKhoan,
      this.idTrinhDo,
      this.idChuyenMon,
      this.idLoaiTotNghiep,
      this.namTotNghiep,
      this.donViDaoTao,
      this.anhBangCap,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  BangBangCapResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idTrinhDo                                                              
    if (json['idTrinhDo'] != null && json['idTrinhDo'].toString().length!=24) {                                                  
      idTrinhDo = TrinhDoResponse.fromJson(json['idTrinhDo'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrinhDo = null;                                                               
    }                                                                                  

    // mapping idChuyenMon                                                              
    if (json['idChuyenMon'] != null && json['idChuyenMon'].toString().length!=24) {                                                  
      idChuyenMon = ChuyenMonResponse.fromJson(json['idChuyenMon'] as Map<String, dynamic>); 
    } else {                                                                           
      idChuyenMon = null;                                                               
    }                                                                                  

    // mapping idLoaiTotNghiep                                                              
    if (json['idLoaiTotNghiep'] != null && json['idLoaiTotNghiep'].toString().length!=24) {                                                  
      idLoaiTotNghiep = LoaiTotNghiepResponse.fromJson(json['idLoaiTotNghiep'] as Map<String, dynamic>); 
    } else {                                                                           
      idLoaiTotNghiep = null;                                                               
    }                                                                                  
    namTotNghiep = json['namTotNghiep'].toString();
    donViDaoTao = json['donViDaoTao'].toString();
    anhBangCap = json['anhBangCap'].toString();

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

    // check null idTrinhDo
    if (idTrinhDo != null) data['idTrinhDo'] = idTrinhDo; 

    // check null idChuyenMon
    if (idChuyenMon != null) data['idChuyenMon'] = idChuyenMon; 

    // check null idLoaiTotNghiep
    if (idLoaiTotNghiep != null) data['idLoaiTotNghiep'] = idLoaiTotNghiep; 

    // check null namTotNghiep
    if (namTotNghiep != null) data['namTotNghiep'] = namTotNghiep; 

    // check null donViDaoTao
    if (donViDaoTao != null) data['donViDaoTao'] = donViDaoTao; 

    // check null anhBangCap
    if (anhBangCap != null) data['anhBangCap'] = anhBangCap; 


    return data;
  }
}
