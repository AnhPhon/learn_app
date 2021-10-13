import 'don_dich_vu_response.dart';
import 'du_an_khach_hang_response.dart';
import 'tin_tuc_response.dart';
import 'tuyen_dung_response.dart';
import 'du_an_nhan_vien_response.dart';

class ThongBaoResponse {
  String? id;
  String? doiTuong;
  DonDichVuResponse? idDonDichVu;
  DuAnKhachHangResponse? idDuAnKhachHang;
  TinTucResponse? idTinTuc;
  TuyenDungResponse? idTuyenDung;
  String? tieuDe;
  String? noiDung;
  String? hinhDaiDien;
  DuAnNhanVienResponse? idDuAnNhanVien;

  String? createdAt;
  String? updatedAt;

  ThongBaoResponse({
      this.id,
      this.doiTuong,
      this.idDonDichVu,
      this.idDuAnKhachHang,
      this.idTinTuc,
      this.idTuyenDung,
      this.tieuDe,
      this.noiDung,
      this.hinhDaiDien,
      this.idDuAnNhanVien,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ThongBaoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    doiTuong = json['doiTuong'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {                                                  
      idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
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

    // check null doiTuong
    if (doiTuong != null) data['doiTuong'] = doiTuong; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idDuAnKhachHang
    if (idDuAnKhachHang != null) data['idDuAnKhachHang'] = idDuAnKhachHang; 

    // check null idTinTuc
    if (idTinTuc != null) data['idTinTuc'] = idTinTuc; 

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 


    return data;
  }
}