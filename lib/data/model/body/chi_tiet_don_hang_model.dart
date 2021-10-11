import 'don_hang_model.dart';
import 'san_pham_model.dart';

class ChiTietDonHangModel {
  DonHangModel? idDonHang;
  SanPhamModel? idSanPham;
  String? soLuong;

  ChiTietDonHangModel({
      this.idDonHang,
      this.idSanPham,
      this.soLuong});
  
  ///
  /// From JSON
  ///
  ChiTietDonHangModel.fromJson(Map<String, dynamic> json) {

    // mapping idDonHang                                                              
    if (json['idDonHang'] != null) {                                                  
      idDonHang = DonHangModel.fromJson(json['idDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonHang = null;                                                               
    }                                                                                  

    // mapping idSanPham                                                              
    if (json['idSanPham'] != null) {                                                  
      idSanPham = SanPhamModel.fromJson(json['idSanPham'] as Map<String, dynamic>); 
    } else {                                                                           
      idSanPham = null;                                                               
    }                                                                                  
    soLuong = json['soLuong'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonHang'] = idDonHang;
    data['idSanPham'] = idSanPham;
    data['soLuong'] = soLuong;
    return data;
  }
}
