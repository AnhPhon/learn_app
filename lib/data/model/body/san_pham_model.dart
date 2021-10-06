class SanPhamModel {
  String? idTaiKhoan;
  String? idDanhMucSanPham;
  String? ten;
  String? thuongHieu;
  String? moTa;
  String? hinhAnhDaiDien;
  String? hinhAnhSanPham;
  String? quyCach;
  String? gia;
  String? maSanPham;
  String? kieuVanChuyen;
  String? idBangGiaPhiVanChuyen;

  SanPhamModel({
      this.idTaiKhoan,
      this.idDanhMucSanPham,
      this.ten,
      this.thuongHieu,
      this.moTa,
      this.hinhAnhDaiDien,
      this.hinhAnhSanPham,
      this.quyCach,
      this.gia,
      this.maSanPham,
      this.kieuVanChuyen,
      this.idBangGiaPhiVanChuyen
      });

  SanPhamModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    idDanhMucSanPham = json['idDanhMucSanPham'].toString();
    ten = json['ten'].toString();
    thuongHieu = json['thuongHieu'].toString();
    moTa = json['moTa'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    hinhAnhSanPham = json['hinhAnhSanPham'].toString();
    quyCach = json['quyCach'].toString();
    gia = json['gia'].toString();
    maSanPham = json['maSanPham'].toString();
    kieuVanChuyen = json['kieuVanChuyen'].toString();
    idBangGiaPhiVanChuyen = json['idBangGiaPhiVanChuyen'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['idDanhMucSanPham'] = idDanhMucSanPham;
    data['ten'] = ten;
    data['thuongHieu'] = thuongHieu;
    data['moTa'] = moTa;
    data['hinhAnhDaiDien'] = hinhAnhDaiDien;
    data['hinhAnhSanPham'] = hinhAnhSanPham;
    data['quyCach'] = quyCach;
    data['gia'] = gia;
    data['maSanPham'] = maSanPham;
    data['kieuVanChuyen'] = kieuVanChuyen;
    data['idBangGiaPhiVanChuyen'] = idBangGiaPhiVanChuyen;
    return data;
  }
}
