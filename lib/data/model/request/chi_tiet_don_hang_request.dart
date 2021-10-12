class ChiTietDonHangRequest {
  String? id;
  String? idDonHang;
  String? idSanPham;
  String? soLuong;
  ChiTietDonHangRequest({
      this.id,
      this.idDonHang,
      this.idSanPham,
      this.soLuong});
  
  ///
  /// From JSON
  ///
  ChiTietDonHangRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idDonHang = json['idDonHang'].toString();
    idSanPham = json['idSanPham'].toString();
    soLuong = json['soLuong'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idDonHang'] = idDonHang;
    data['idSanPham'] = idSanPham;
    data['soLuong'] = soLuong;
    return data;
  }
}
