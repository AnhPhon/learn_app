import 'nhan_vien_model.dart';
import 'du_an_nhan_vien_model.dart';
import 'tinh_tp_model.dart';
import 'quan_huyen_model.dart';
import 'phuong_xa_model.dart';

class ChamCongModel {
  NhanVienModel? idNhanVien;
  DuAnNhanVienModel? idDuAnNhanVien;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  TinhTpModel? idTinhTp;
  QuanHuyenModel? idQuanHuyen;
  PhuongXaModel? idPhuongXa;
  String? diaChi;
  String? noiDungBaoCao;
  String? viTri;

  ChamCongModel({
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.noiDungBaoCao,
      this.viTri});
  
  ///
  /// From JSON
  ///
  ChamCongModel.fromJson(Map<String, dynamic> json) {

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
    thoiGianBatDau = json['thoiGianBatDau'].toString();
    thoiGianKetThuc = json['thoiGianKetThuc'].toString();

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
    diaChi = json['diaChi'].toString();
    noiDungBaoCao = json['noiDungBaoCao'].toString();
    viTri = json['viTri'].toString();

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

    // check null thoiGianBatDau
    if (thoiGianBatDau != null) data['thoiGianBatDau'] = thoiGianBatDau; 

    // check null thoiGianKetThuc
    if (thoiGianKetThuc != null) data['thoiGianKetThuc'] = thoiGianKetThuc; 

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp; 

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen; 

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa; 

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi; 

    // check null noiDungBaoCao
    if (noiDungBaoCao != null) data['noiDungBaoCao'] = noiDungBaoCao; 

    // check null viTri
    if (viTri != null) data['viTri'] = viTri; 


    return data;
  }
}
