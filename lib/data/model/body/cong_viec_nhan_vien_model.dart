import 'nhan_vien_model.dart';
import 'du_an_nhan_vien_model.dart';

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
    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien; 

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien; 

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai; 

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe; 

    // check null tomTat
    if (tomTat != null) data['tomTat'] = tomTat; 

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung; 

    // check null ngayBatDau
    if (ngayBatDau != null) data['ngayBatDau'] = ngayBatDau; 

    // check null ngayKetThuc
    if (ngayKetThuc != null) data['ngayKetThuc'] = ngayKetThuc; 

    // check null ngayThucTe
    if (ngayThucTe != null) data['ngayThucTe'] = ngayThucTe; 


    return data;
  }
}
