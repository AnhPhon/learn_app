import 'don_dich_vu_model.dart';
import 'du_an_khach_hang_model.dart';
import 'tin_tuc_model.dart';
import 'tuyen_dung_model.dart';
import 'du_an_nhan_vien_model.dart';

class ThongBaoModel {
  String? doiTuong;
  DonDichVuModel? idDonDichVu;
  DuAnKhachHangModel? idDuAnKhachHang;
  TinTucModel? idTinTuc;
  TuyenDungModel? idTuyenDung;
  String? tieuDe;
  String? noiDung;
  String? hinhDaiDien;
  DuAnNhanVienModel? idDuAnNhanVien;

  ThongBaoModel({
      this.doiTuong,
      this.idDonDichVu,
      this.idDuAnKhachHang,
      this.idTinTuc,
      this.idTuyenDung,
      this.tieuDe,
      this.noiDung,
      this.hinhDaiDien,
      this.idDuAnNhanVien});
  
  ///
  /// From JSON
  ///
  ThongBaoModel.fromJson(Map<String, dynamic> json) {
    doiTuong = json['doiTuong'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null) {                                                  
      idDonDichVu = DonDichVuModel.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping idDuAnKhachHang                                                              
    if (json['idDuAnKhachHang'] != null) {                                                  
      idDuAnKhachHang = DuAnKhachHangModel.fromJson(json['idDuAnKhachHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnKhachHang = null;                                                               
    }                                                                                  

    // mapping idTinTuc                                                              
    if (json['idTinTuc'] != null) {                                                  
      idTinTuc = TinTucModel.fromJson(json['idTinTuc'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinTuc = null;                                                               
    }                                                                                  

    // mapping idTuyenDung                                                              
    if (json['idTuyenDung'] != null) {                                                  
      idTuyenDung = TuyenDungModel.fromJson(json['idTuyenDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idTuyenDung = null;                                                               
    }                                                                                  
    tieuDe = json['tieuDe'].toString();
    noiDung = json['noiDung'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null) {                                                  
      idDuAnNhanVien = DuAnNhanVienModel.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
