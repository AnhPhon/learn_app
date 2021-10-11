import 'loai_van_chuyen_model.dart';
import 'san_pham_model.dart';

class BangGiaPhiVanChuyenModel {
  LoaiVanChuyenModel? idLoaiVanChuyen;
  SanPhamModel? idSanPham;
  String? soTien;

  BangGiaPhiVanChuyenModel({
      this.idLoaiVanChuyen,
      this.idSanPham,
      this.soTien});
  
  ///
  /// From JSON
  ///
  BangGiaPhiVanChuyenModel.fromJson(Map<String, dynamic> json) {

    // mapping idLoaiVanChuyen                                                              
    if (json['idLoaiVanChuyen'] != null) {                                                  
      idLoaiVanChuyen = LoaiVanChuyenModel.fromJson(json['idLoaiVanChuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idLoaiVanChuyen = null;                                                               
    }                                                                                  

    // mapping idSanPham                                                              
    if (json['idSanPham'] != null) {                                                  
      idSanPham = SanPhamModel.fromJson(json['idSanPham'] as Map<String, dynamic>); 
    } else {                                                                           
      idSanPham = null;                                                               
    }                                                                                  
    soTien = json['soTien'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLoaiVanChuyen'] = idLoaiVanChuyen;
    data['idSanPham'] = idSanPham;
    data['soTien'] = soTien;
    return data;
  }
}
