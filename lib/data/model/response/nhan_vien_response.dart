import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';

class NhanVienResponse {
  String? id;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
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

  NhanVienResponse({
      this.id,
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
  NhanVienResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

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
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null hoTen
    if (hoTen != null) data['hoTen'] = hoTen; 

    // check null soDienThoai
    if (soDienThoai != null) data['soDienThoai'] = soDienThoai; 

    // check null gioiTinh
    if (gioiTinh != null) data['gioiTinh'] = gioiTinh; 

    // check null cMND
    if (cMND != null) data['cMND'] = cMND; 

    // check null ngayCap
    if (ngayCap != null) data['ngayCap'] = ngayCap; 

    // check null noiCap
    if (noiCap != null) data['noiCap'] = noiCap; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null hinhDaiDien
    if (hinhDaiDien != null) data['hinhDaiDien'] = hinhDaiDien; 

    // check null anhMTCMND
    if (anhMTCMND != null) data['anhMTCMND'] = anhMTCMND; 

    // check null anhMSCMND
    if (anhMSCMND != null) data['anhMSCMND'] = anhMSCMND; 

    // check null matKhau
    if (matKhau != null) data['matKhau'] = matKhau; 

    // check null tokenDevice
    if (tokenDevice != null) data['tokenDevice'] = tokenDevice; 


    return data;
  }
}
