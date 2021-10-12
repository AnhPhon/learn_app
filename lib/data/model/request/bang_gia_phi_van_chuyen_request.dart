class BangGiaPhiVanChuyenRequest {
  String? id;
  String? idLoaiVanChuyen;
  String? idSanPham;
  String? soTien;

  BangGiaPhiVanChuyenRequest({
      this.id,
      this.idLoaiVanChuyen,
      this.idSanPham,
      this.soTien});
  
  ///
  /// From JSON
  ///
  BangGiaPhiVanChuyenRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idLoaiVanChuyen = json['idLoaiVanChuyen'].toString();
    idSanPham = json['idSanPham'].toString();
    soTien = json['soTien'].toString();
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
