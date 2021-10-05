class BangGiaPhiVanChuyenModel {
  String? idLoaiVanChuyen;
  String? idSanPham;
  String? soTien;

  BangGiaPhiVanChuyenModel({
      this.idLoaiVanChuyen,
      this.idSanPham,
      this.soTien
      });

  BangGiaPhiVanChuyenModel.fromJson(Map<String, dynamic> json) {
    idLoaiVanChuyen = json['idLoaiVanChuyen'].toString();
    idSanPham = json['idSanPham'].toString();
    soTien = json['soTien'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLoaiVanChuyen'] = idLoaiVanChuyen;
    data['idSanPham'] = idSanPham;
    data['soTien'] = soTien;
    return data;
  }
}
