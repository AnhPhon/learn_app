import 'tai_khoan_model.dart';
import 'tinh_tp_model.dart';
import 'quan_huyen_model.dart';
import 'phuong_xa_model.dart';
import 'hang_muc_xay_dung_model.dart';
import 'trang_thai_du_an_model.dart';

class DuAnKhachHangModel {
  TaiKhoanModel? idTaiKhoan;
  String? ten;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? diaDiem;
  String? gioiThieu;
  String? giaDuyet;
  HangMucXayDungModel? idHangMucXayDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? thoiGianYeuCau;
  String? file;
  String? hinhAnhDaiDien;
  TrangThaiDuAnModel? idTrangThaiDuAn;
  String? taiKhoanTrungThau;

  DuAnKhachHangModel({
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
  DuAnKhachHangModel.fromJson(Map<String, dynamic> json) {

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    ten = json['ten'].toString();

    // mapping idTinhTp                                                              
    if (json['idTinhTp'] != null) {                                                  
      idTinhTp = TinhTpModel.fromJson(json['idTinhTp'] as Map<String, dynamic>); 
    } else {                                                                           
      idTinhTp = null;                                                               
    }                                                                                  

    // mapping idQuanHuyen                                                              
    if (json['idQuanHuyen'] != null) {                                                  
      idQuanHuyen = QuanHuyenModel.fromJson(json['idQuanHuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idQuanHuyen = null;                                                               
    }                                                                                  

    // mapping idPhuongXa                                                              
    if (json['idPhuongXa'] != null) {                                                  
      idPhuongXa = PhuongXaModel.fromJson(json['idPhuongXa'] as Map<String, dynamic>); 
    } else {                                                                           
      idPhuongXa = null;                                                               
    }                                                                                  
    diaDiem = json['diaDiem'].toString();
    gioiThieu = json['gioiThieu'].toString();
    giaDuyet = json['giaDuyet'].toString();

    // mapping idHangMucXayDung                                                              
    if (json['idHangMucXayDung'] != null) {                                                  
      idHangMucXayDung = HangMucXayDungModel.fromJson(json['idHangMucXayDung'] as Map<String, dynamic>); 
    } else {                                                                           
      idHangMucXayDung = null;                                                               
    }                                                                                  
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    thoiGianYeuCau = json['thoiGianYeuCau'].toString();
    file = json['file'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();

    // mapping idTrangThaiDuAn                                                              
    if (json['idTrangThaiDuAn'] != null) {                                                  
      idTrangThaiDuAn = TrangThaiDuAnModel.fromJson(json['idTrangThaiDuAn'] as Map<String, dynamic>); 
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
