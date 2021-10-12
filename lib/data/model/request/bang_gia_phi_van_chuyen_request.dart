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
    data['id'] = id;
    data['idLoaiVanChuyen'] = idLoaiVanChuyen;
    data['idSanPham'] = idSanPham;
    data['soTien'] = soTien;
    return data;
  }
}
