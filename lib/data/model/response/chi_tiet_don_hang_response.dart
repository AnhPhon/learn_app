import 'don_hang_response.dart';
import 'san_pham_response.dart';

class ChiTietDonHangResponse {
  String? id;
  DonHangResponse? idDonHang;
  SanPhamResponse? idSanPham;
  String? soLuong;

  String? createdAt;
  String? updatedAt;

  ChiTietDonHangResponse({
      this.id,
      this.idDonHang,
      this.idSanPham,
      this.soLuong,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ChiTietDonHangResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idDonHang                                                              
    if (json['idDonHang'] != null && json['idDonHang'].toString().length!=24) {                                                  
      idDonHang = DonHangResponse.fromJson(json['idDonHang'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonHang = null;                                                               
    }                                                                                  

    // mapping idSanPham                                                              
    if (json['idSanPham'] != null && json['idSanPham'].toString().length!=24) {                                                  
      idSanPham = SanPhamResponse.fromJson(json['idSanPham'] as Map<String, dynamic>); 
    } else {                                                                           
      idSanPham = null;                                                               
    }                                                                                  
    soLuong = json['soLuong'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDonHang
    if (idDonHang != null) data['idDonHang'] = idDonHang; 

    // check null idSanPham
    if (idSanPham != null) data['idSanPham'] = idSanPham; 

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong; 


    return data;
  }
}
