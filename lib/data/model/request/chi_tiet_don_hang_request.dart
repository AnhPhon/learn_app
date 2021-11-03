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
    id = (json['id'] == null) ? null : json['id'].toString();
    idDonHang = json['idDonHang'].toString();
    idSanPham = json['idSanPham'].toString();
    soLuong = json['soLuong'].toString();
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
