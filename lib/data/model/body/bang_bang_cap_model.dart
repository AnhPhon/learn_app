import 'chuyen_mon_model.dart';
import 'loai_tot_nghiep_model.dart';
import 'tai_khoan_model.dart';
import 'trinh_do_model.dart';

class BangBangCapModel {
  TaiKhoanModel? idTaiKhoan;
  TrinhDoModel? idTrinhDo;
  ChuyenMonModel? idChuyenMon;
  LoaiTotNghiepModel? idLoaiTotNghiep;
  String? namTotNghiep;
  String? donViDaoTao;
  String? anhBangCap;

  BangBangCapModel({
      this.idTaiKhoan,
      this.idTrinhDo,
      this.idChuyenMon,
      this.idLoaiTotNghiep,
      this.namTotNghiep,
      this.donViDaoTao,
      this.anhBangCap});
  
  ///
  /// From JSON
  ///
  BangBangCapModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  

    // mapping idTrinhDo                                                              
    if (json['idTrinhDo'] != null) {                                                  
      idTrinhDo = TrinhDoModel.fromJson(json['idTrinhDo'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrinhDo = null;                                                               
    }                                                                                  

    // mapping idChuyenMon                                                              
    if (json['idChuyenMon'] != null) {                                                  
      idChuyenMon = ChuyenMonModel.fromJson(json['idChuyenMon'] as Map<String, dynamic>); 
    } else {                                                                           
      idChuyenMon = null;                                                               
    }                                                                                  

    // mapping idLoaiTotNghiep                                                              
    if (json['idLoaiTotNghiep'] != null) {                                                  
      idLoaiTotNghiep = LoaiTotNghiepModel.fromJson(json['idLoaiTotNghiep'] as Map<String, dynamic>); 
    } else {                                                                           
      idLoaiTotNghiep = null;                                                               
    }                                                                                  
    namTotNghiep = json['namTotNghiep'].toString();
    donViDaoTao = json['donViDaoTao'].toString();
    anhBangCap = json['anhBangCap'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['idTrinhDo'] = idTrinhDo;
    data['idChuyenMon'] = idChuyenMon;
    data['idLoaiTotNghiep'] = idLoaiTotNghiep;
    data['namTotNghiep'] = namTotNghiep;
    data['donViDaoTao'] = donViDaoTao;
    data['anhBangCap'] = anhBangCap;
    return data;
  }
}
