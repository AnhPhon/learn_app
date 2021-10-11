import 'don_dich_vu_model.dart';
import 'du_an_khach_hang_model.dart';
import 'du_an_nhan_vien_model.dart';
import 'tin_tuc_model.dart';
import 'tuyen_dung_model.dart';

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
    data['doiTuong'] = doiTuong;
    data['idDonDichVu'] = idDonDichVu;
    data['idDuAnKhachHang'] = idDuAnKhachHang;
    data['idTinTuc'] = idTinTuc;
    data['idTuyenDung'] = idTuyenDung;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    data['hinhDaiDien'] = hinhDaiDien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    return data;
  }
}
