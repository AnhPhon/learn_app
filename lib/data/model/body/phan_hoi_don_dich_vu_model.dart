import 'don_dich_vu_model.dart';
import 'tai_khoan_model.dart';

class PhanHoiDonDichVuModel {
  DonDichVuModel? idDonDichVu;
  TaiKhoanModel? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? yKienThoThau;
  String? khachHangDanhGia;
  String? yeuCauBaoHanh;
  String? hinhAnhHuHai;
  String? noiDungYeuCauBaoHanh;
  String? danhGiaBaoHanh;
  String? tinhTrangThanhToan;

  PhanHoiDonDichVuModel({
      this.idDonDichVu,
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.yKienThoThau,
      this.khachHangDanhGia,
      this.yeuCauBaoHanh,
      this.hinhAnhHuHai,
      this.noiDungYeuCauBaoHanh,
      this.danhGiaBaoHanh,
      this.tinhTrangThanhToan});
  
  ///
  /// From JSON
  ///
  PhanHoiDonDichVuModel.fromJson(Map<String, dynamic> json) {

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null) {                                                  
      idDonDichVu = DonDichVuModel.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping idTaiKhoan                                                              
    if (json['idTaiKhoan'] != null) {                                                  
      idTaiKhoan = TaiKhoanModel.fromJson(json['idTaiKhoan'] as Map<String, dynamic>); 
    } else {                                                                           
      idTaiKhoan = null;                                                               
    }                                                                                  
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    yKienThoThau = json['yKienThoThau'].toString();
    khachHangDanhGia = json['khachHangDanhGia'].toString();
    yeuCauBaoHanh = json['yeuCauBaoHanh'].toString();
    hinhAnhHuHai = json['hinhAnhHuHai'].toString();
    noiDungYeuCauBaoHanh = json['noiDungYeuCauBaoHanh'].toString();
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    tinhTrangThanhToan = json['tinhTrangThanhToan'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon; 

    // check null yKienThoThau
    if (yKienThoThau != null) data['yKienThoThau'] = yKienThoThau; 

    // check null khachHangDanhGia
    if (khachHangDanhGia != null) data['khachHangDanhGia'] = khachHangDanhGia; 

    // check null yeuCauBaoHanh
    if (yeuCauBaoHanh != null) data['yeuCauBaoHanh'] = yeuCauBaoHanh; 

    // check null hinhAnhHuHai
    if (hinhAnhHuHai != null) data['hinhAnhHuHai'] = hinhAnhHuHai; 

    // check null noiDungYeuCauBaoHanh
    if (noiDungYeuCauBaoHanh != null) data['noiDungYeuCauBaoHanh'] = noiDungYeuCauBaoHanh; 

    // check null danhGiaBaoHanh
    if (danhGiaBaoHanh != null) data['danhGiaBaoHanh'] = danhGiaBaoHanh; 

    // check null tinhTrangThanhToan
    if (tinhTrangThanhToan != null) data['tinhTrangThanhToan'] = tinhTrangThanhToan; 


    return data;
  }
}
