class ChiTietDonHangModel {
  String? idDonHang;
  String? idSanPham;
  String? soLuong;

  ChiTietDonHangModel({
      this.idDonHang,
      this.idSanPham,
      this.soLuong
      });

  ChiTietDonHangModel.fromJson(Map<String, dynamic> json) {
    idDonHang = json['idDonHang'].toString();
    idSanPham = json['idSanPham'].toString();
    soLuong = json['soLuong'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonHang'] = idDonHang;
    data['idSanPham'] = idSanPham;
    data['soLuong'] = soLuong;
    return data;
  }
}
