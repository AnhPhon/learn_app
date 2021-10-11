import 'tinh_tp_model.dart';
import 'quan_huyen_model.dart';
import 'phuong_xa_model.dart';

class NhanVienModel {
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? hoTen;
  String? soDienThoai;
  String? gioiTinh;
  String? cMND;
  String? ngayCap;
  String? noiCap;
  String? diaChi;
  String? hinhDaiDien;
  String? anhMTCMND;
  String? anhMSCMND;
  String? matKhau;
  String? tokenDevice;

  NhanVienModel({
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.hoTen,
      this.soDienThoai,
      this.gioiTinh,
      this.cMND,
      this.ngayCap,
      this.noiCap,
      this.diaChi,
      this.hinhDaiDien,
      this.anhMTCMND,
      this.anhMSCMND,
      this.matKhau,
      this.tokenDevice});
  
  ///
  /// From JSON
  ///
  NhanVienModel.fromJson(Map<String, dynamic> json) {

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
    hoTen = json['hoTen'].toString();
    soDienThoai = json['soDienThoai'].toString();
    gioiTinh = json['gioiTinh'].toString();
    cMND = json['cMND'].toString();
    ngayCap = json['ngayCap'].toString();
    noiCap = json['noiCap'].toString();
    diaChi = json['diaChi'].toString();
    hinhDaiDien = json['hinhDaiDien'].toString();
    anhMTCMND = json['anhMTCMND'].toString();
    anhMSCMND = json['anhMSCMND'].toString();
    matKhau = json['matKhau'].toString();
    tokenDevice = json['tokenDevice'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTinhTp'] = idTinhTp;
    data['idQuanHuyen'] = idQuanHuyen;
    data['idPhuongXa'] = idPhuongXa;
    data['hoTen'] = hoTen;
    data['soDienThoai'] = soDienThoai;
    data['gioiTinh'] = gioiTinh;
    data['cMND'] = cMND;
    data['ngayCap'] = ngayCap;
    data['noiCap'] = noiCap;
    data['diaChi'] = diaChi;
    data['hinhDaiDien'] = hinhDaiDien;
    data['anhMTCMND'] = anhMTCMND;
    data['anhMSCMND'] = anhMSCMND;
    data['matKhau'] = matKhau;
    data['tokenDevice'] = tokenDevice;
    return data;
  }
}
