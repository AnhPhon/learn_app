import 'du_an_khach_hang_model.dart';
import 'trang_thai_bao_gia_model.dart';

class DanhSachThoThauBaoGiaModel {
  DuAnKhachHangModel? idDuAnKhachHang;
  String? taiKhoanBaoGia;
  TrangThaiBaoGiaModel? idTrangThaiBaoGia;
  String? thoiGianHoanThanh;
  String? giaBao;
  String? ghiChu;
  String? tienCoc;
  String? daXem;

  DanhSachThoThauBaoGiaModel({
      this.idDuAnKhachHang,
      this.taiKhoanBaoGia,
      this.idTrangThaiBaoGia,
      this.thoiGianHoanThanh,
      this.giaBao,
      this.ghiChu,
      this.tienCoc,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachThoThauBaoGiaModel.fromJson(Map<String, dynamic> json) {

    // mapping idDuAnKhachHang                                                              
    if (json['idDuAnKhachHang'] != null) {                                                  
      idDuAnKhachHang = DuAnKhachHangModel.fromJson(json['idDuAnKhachHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idDuAnKhachHang = null;                                                               
    }                                                                                  
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();

    // mapping idTrangThaiBaoGia                                                              
    if (json['idTrangThaiBaoGia'] != null) {                                                  
      idTrangThaiBaoGia = TrangThaiBaoGiaModel.fromJson(json['idTrangThaiBaoGia'] as Map<String, dynamic>); 
    } else {                                                                           
      idTrangThaiBaoGia = null;                                                               
    }                                                                                  
    thoiGianHoanThanh = json['thoiGianHoanThanh'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    tienCoc = json['tienCoc'].toString();
    daXem = json['daXem'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDuAnKhachHang'] = idDuAnKhachHang;
    data['taiKhoanBaoGia'] = taiKhoanBaoGia;
    data['idTrangThaiBaoGia'] = idTrangThaiBaoGia;
    data['thoiGianHoanThanh'] = thoiGianHoanThanh;
    data['giaBao'] = giaBao;
    data['ghiChu'] = ghiChu;
    data['tienCoc'] = tienCoc;
    data['daXem'] = daXem;
    return data;
  }
}
