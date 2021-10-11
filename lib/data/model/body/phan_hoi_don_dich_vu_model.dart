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
    data['idDonDichVu'] = idDonDichVu;
    data['idTaiKhoan'] = idTaiKhoan;
    data['taiKhoanNhanDon'] = taiKhoanNhanDon;
    data['yKienThoThau'] = yKienThoThau;
    data['khachHangDanhGia'] = khachHangDanhGia;
    data['yeuCauBaoHanh'] = yeuCauBaoHanh;
    data['hinhAnhHuHai'] = hinhAnhHuHai;
    data['noiDungYeuCauBaoHanh'] = noiDungYeuCauBaoHanh;
    data['danhGiaBaoHanh'] = danhGiaBaoHanh;
    data['tinhTrangThanhToan'] = tinhTrangThanhToan;
    return data;
  }
}
