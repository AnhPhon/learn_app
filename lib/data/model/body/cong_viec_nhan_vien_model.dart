import 'du_an_nhan_vien_model.dart';
import 'nhan_vien_model.dart';

class CongViecNhanVienModel {
  NhanVienModel? idNhanVien;
  DuAnNhanVienModel? idDuAnNhanVien;
  String? trangThai;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? ngayThucTe;

  CongViecNhanVienModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.trangThai,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.ngayThucTe});
  
  ///
  /// From JSON
  ///
  CongViecNhanVienModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhanVien                                                              
    if (json['idNhanVien'] != null) {                                                  
      idNhanVien = NhanVienModel.fromJson(json['idNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhanVien = null;                                                               
    }                                                                                  

    // mapping idDuAnNhanVien                                                              
    if (json['idDuAnNhanVien'] != null) {                                                  
      idDuAnNhanVien = DuAnNhanVienModel.fromJson(json['idDuAnNhanVien'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnNhanVien = null;                                                               
    }                                                                                  
    trangThai = json['trangThai'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    ngayThucTe = json['ngayThucTe'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['trangThai'] = trangThai;
    data['tieuDe'] = tieuDe;
    data['tomTat'] = tomTat;
    data['noiDung'] = noiDung;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['ngayThucTe'] = ngayThucTe;
    return data;
  }
}
