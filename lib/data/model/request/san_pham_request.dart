class SanPhamRequest {
  String? id;
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

  SanPhamRequest({
      this.id,
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
      this.idBangGiaPhiVanChuyen});
  
  ///
  /// From JSON
  ///
  SanPhamRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
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

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan; 

    // check null idDanhMucSanPham
    if (idDanhMucSanPham != null) data['idDanhMucSanPham'] = idDanhMucSanPham; 

    // check null ten
    if (ten != null) data['ten'] = ten; 

    // check null thuongHieu
    if (thuongHieu != null) data['thuongHieu'] = thuongHieu; 

    // check null moTa
    if (moTa != null) data['moTa'] = moTa; 

    // check null hinhAnhDaiDien
    if (hinhAnhDaiDien != null) data['hinhAnhDaiDien'] = hinhAnhDaiDien; 

    // check null hinhAnhSanPham
    if (hinhAnhSanPham != null) data['hinhAnhSanPham'] = hinhAnhSanPham; 

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach; 

    // check null gia
    if (gia != null) data['gia'] = gia; 

    // check null maSanPham
    if (maSanPham != null) data['maSanPham'] = maSanPham; 

    // check null kieuVanChuyen
    if (kieuVanChuyen != null) data['kieuVanChuyen'] = kieuVanChuyen; 

    // check null idBangGiaPhiVanChuyen
    if (idBangGiaPhiVanChuyen != null) data['idBangGiaPhiVanChuyen'] = idBangGiaPhiVanChuyen; 


    return data;
  }
}
