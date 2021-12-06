import 'loai_van_chuyen_response.dart';
import 'san_pham_response.dart';

class BangGiaPhiVanChuyenResponse {
  String? id;
  LoaiVanChuyenResponse? idLoaiVanChuyen;
  SanPhamResponse? idSanPham;
  String? soTien;

  String? createdAt;
  String? updatedAt;

  BangGiaPhiVanChuyenResponse({
      this.id,
      this.idLoaiVanChuyen,
      this.idSanPham,
      this.soTien,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  BangGiaPhiVanChuyenResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idLoaiVanChuyen                                                              
    if (json['idLoaiVanChuyen'] != null && json['idLoaiVanChuyen'].toString().length!=24) {                                                  
      idLoaiVanChuyen = LoaiVanChuyenResponse.fromJson(json['idLoaiVanChuyen'] as Map<String, dynamic>); 
    } else {                                                                           
      idLoaiVanChuyen = null;                                                               
    }                                                                                  

    // mapping idSanPham                                                              
    if (json['idSanPham'] != null && json['idSanPham'].toString().length!=24) {                                                  
      idSanPham = SanPhamResponse.fromJson(json['idSanPham'] as Map<String, dynamic>); 
    } else {                                                                           
      idSanPham = null;                                                               
    }                                                                                  
    soTien = json['soTien'].toString();

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

    // check null idLoaiVanChuyen
    if (idLoaiVanChuyen != null) data['idLoaiVanChuyen'] = idLoaiVanChuyen; 

    // check null idSanPham
    if (idSanPham != null) data['idSanPham'] = idSanPham; 

    // check null soTien
    if (soTien != null) data['soTien'] = soTien; 


    return data;
  }
}
