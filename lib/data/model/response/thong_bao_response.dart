import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';

import 'don_dich_vu_response.dart';
import 'du_an_khach_hang_response.dart';
import 'tin_tuc_response.dart';
import 'tuyen_dung_response.dart';
import 'du_an_nhan_vien_response.dart';

class ThongBaoResponse {
  String? id;
  List<String>? doiTuongs;
  String? status;
  DonDichVuResponse? idDonDichVu;
  PhanHoiDonDichVuResponse? idPhanHoiDonDichVu;
  DuAnKhachHangResponse? idDuAnKhachHang;
  TinTucResponse? idTinTuc;
  TuyenDungResponse? idTuyenDung;
  String? tieuDe;
  String? noiDung;
  String? hinhDaiDien;
  DuAnNhanVienResponse? idDuAnNhanVien;
  String? idTaiKhoan;
  String? nguoiGui;
  String? trangThaiTrungThau;
  String? createdAt;
  String? updatedAt;

  ThongBaoResponse({
      this.id,
      this.doiTuongs,
      this.nguoiGui,
      this.trangThaiTrungThau,
      this.status,
      this.idDonDichVu,
      this.idDuAnKhachHang,
      this.idTinTuc,
      this.idTuyenDung,
      this.tieuDe,
      this.noiDung,
      this.hinhDaiDien,
      this.idDuAnNhanVien,
      this.idTaiKhoan,
      this.idPhanHoiDonDichVu,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongBaoResponse.fromJson(Map<String, dynamic> json) {
    print("Notificaiton: $json");
    id = (json['id'] == null) ? null : json['id'].toString();
    doiTuongs = (json['doiTuongs'] as List<dynamic>).cast<String>();
    nguoiGui = json['nguoiGui'].toString();
    trangThaiTrungThau =  (json['trangThaiTrungThau'] != null) ? json['trangThaiTrungThau'].toString() : null;
    status = json['status'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {                                                  
      idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }  

    // mapping idPhanHoiDonDichVu                                                              
    if (json['idPhanHoiDonDichVu'] != null && json['idPhanHoiDonDichVu'].toString().length!=24) {                                                  
      idPhanHoiDonDichVu = PhanHoiDonDichVuResponse.fromJson(json['idPhanHoiDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhanHoiDonDichVu = null;                                                               
    }                                                                                  

    // mapping idDuAnKhachHang                                                              
    if (json['idDuAnKhachHang'] != null && json['idDuAnKhachHang'].toString().length!=24) {                                                  
      idDuAnKhachHang = DuAnKhachHangResponse.fromJson(json['idDuAnKhachHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnKhachHang = null;                                                               
    }                                                                                  

    // mapping idTinTuc                                                              
    if (json['idTinTuc'] != null && json['idTinTuc'].toString().length!=24) {                                                  
      idTinTuc = TinTucResponse.fromJson(json['idTinTuc'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinTuc = null;                                                               
    }                                                                                  

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null && json['idTuyenDung'].toString().length!=24) {                                                  
      idTuyenDung = TuyenDungResponse.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null && json['idDuAnNhanVien'].toString().length!=24) {                                                  
      idDuAnNhanVien = DuAnNhanVienResponse.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  

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

    // check null doiTuongs
    if (doiTuongs != null) data['doiTuongs'] = doiTuongs; 
    // Người gửi
    if (nguoiGui != null) data['nguoiGui'] = nguoiGui; 
    // Trang thái trúng thầu
    if (trangThaiTrungThau != null) data['trangThaiTrungThau'] = trangThaiTrungThau; 
    //Check thông báo
    if (status != null) data['status'] = status; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idPhanHoiDonDichVu
    if (idPhanHoiDonDichVu != null) data['idPhanHoiDonDichVu'] = idPhanHoiDonDichVu; 

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang; 

    // check null idTinTuc
    if (idTinTuc != null) data['idTinTuc'] = idTinTuc; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 


    return data;
  }
}
