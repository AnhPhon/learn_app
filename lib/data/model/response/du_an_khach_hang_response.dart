import 'tai_khoan_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'hang_muc_xay_dung_response.dart';
import 'trang_thai_du_an_response.dart';

class DuAnKhachHangResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? ten;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? diaDiem;
  String? gioiThieu;
  String? giaDuyet;
  HangMucXayDungResponse? idHangMucXayDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? thoiGianYeuCau;
  String? file;
  String? hinhAnhDaiDien;
  TrangThaiDuAnResponse? idTrangThaiDuAn;
  String? taiKhoanTrungThau;

  DuAnKhachHangResponse({
      this.id,
      this.idTaiKhoan,
      this.ten,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaDiem,
      this.gioiThieu,
      this.giaDuyet,
      this.idHangMucXayDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.thoiGianYeuCau,
      this.file,
      this.hinhAnhDaiDien,
      this.idTrangThaiDuAn,
      this.taiKhoanTrungThau});
  
  ///
  /// From JSON
  ///
  DuAnKhachHangResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null && json['idTaiKhoan'].toString().length!=24) {                                                  
      idTaiKhoan = TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    ten = json['ten'].toString();

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length!=24) {                                                  
      idTinhTp = TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null && json['idQuanHuyen'].toString().length!=24) {                                                  
      idQuanHuyen = QuanHuyenResponse.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null && json['idPhuongXa'].toString().length!=24) {                                                  
      idPhuongXa = PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    diaDiem = json['diaDiem'].toString();
    gioiThieu = json['gioiThieu'].toString();
    giaDuyet = json['giaDuyet'].toString();

    // mapping idHangMucXayDung                                                              
    if (json['idHangMucXayDung'] != null && json['idHangMucXayDung'].toString().length!=24) {                                                  
      idHangMucXayDung = HangMucXayDungResponse.fromJson(json['idHangMucXayDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idHangMucXayDung = null;                                                               
    }                                                                                  
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    thoiGianYeuCau = json['thoiGianYeuCau'].toString();
    file = json['file'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();

    // mapping idTrangThaiDuAn                                                              
    if (json['idTrangThaiDuAn'] != null && json['idTrangThaiDuAn'].toString().length!=24) {                                                  
      idTrangThaiDuAn = TrangThaiDuAnResponse.fromJson(json['idTrangThaiDuAn'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiDuAn = null;                                                               
    }                                                                                  
    taiKhoanTrungThau = json['taiKhoanTrungThau'].toString();

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

    // check null ten
    if (ten != null) data['ten'] = ten; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaDiem
    if (diaDiem != null) data['diaDiem'] = diaDiem; 

    // check null gioiThieu
    if (gioiThieu != null) data['gioiThieu'] = gioiThieu; 

    // check null giaDuyet
    if (giaDuyet != null) data['giaDuyet'] = giaDuyet; 

    // check null idHangMucXayDung
    if (idHangMucXayDung != null) data['idHangMucXayDung'] = idHangMucXayDung; 

    // check null ngayBatDau
    if (ngayBatDau != null) data['ngayBatDau'] = ngayBatDau; 

    // check null ngayKetThuc
    if (ngayKetThuc != null) data['ngayKetThuc'] = ngayKetThuc; 

    // check null thoiGianYeuCau
    if (thoiGianYeuCau != null) data['thoiGianYeuCau'] = thoiGianYeuCau; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien; 

    // check null idTrangThaiDuAn
    if (idTrangThaiDuAn != null) data['idTrangThaiDuAn'] = idTrangThaiDuAn; 

    // check null taiKhoanTrungThau
    if (taiKhoanTrungThau != null) data['taiKhoanTrungThau'] = taiKhoanTrungThau; 


    return data;
  }
}
