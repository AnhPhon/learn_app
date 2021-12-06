class SanPhamRequest {
  String? id;
  String? idTaiKhoan;
  String? idDanhMucSanPham;
  String? ten;
  String? thuongHieu;
  String? moTa;
  String? hinhAnhDaiDien;
  List<String>? hinhAnhSanPhams;
  String? quyCach;
  String? gia;
  String? maSanPham;
  String? donVi;
  String? kieuVanChuyen;
  String? tinhTrangSanPham;
  String? idBangGiaPhiVanChuyen;

  SanPhamRequest(
      {this.id,
      this.idTaiKhoan,
      this.idDanhMucSanPham,
      this.ten,
      this.thuongHieu,
      this.moTa,
      this.hinhAnhDaiDien,
      this.hinhAnhSanPhams,
      this.quyCach,
      this.gia,
      this.maSanPham,
      this.donVi,
      this.kieuVanChuyen,
      this.tinhTrangSanPham,
      this.idBangGiaPhiVanChuyen});

  ///
  /// From JSON
  ///
  SanPhamRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idDanhMucSanPham = json['idDanhMucSanPham'].toString();
    ten = json['ten'].toString();
    thuongHieu = json['thuongHieu'].toString();
    moTa = json['moTa'].toString();
    hinhAnhDaiDien = json['hinhAnhDaiDien'].toString();
    hinhAnhSanPhams = (json['hinhAnhSanPhams'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
    quyCach = json['quyCach'].toString();
    gia = json['gia'].toString();
    maSanPham = json['maSanPham'].toString();
    donVi = json['donVi'].toString();
    kieuVanChuyen = json['kieuVanChuyen'].toString();
    tinhTrangSanPham = json['tinhTrangSanPham'].toString();
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

    // check null hinhAnhSanPhams
    if (hinhAnhSanPhams != null) data['hinhAnhSanPhams'] = hinhAnhSanPhams;

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach;

    // check null gia
    if (gia != null) data['gia'] = gia;

    // check null maSanPham
    if (maSanPham != null) data['maSanPham'] = maSanPham;

    // check null donVi
    if (donVi != null) data['donVi'] = donVi;

    // check null kieuVanChuyen
    if (kieuVanChuyen != null) data['kieuVanChuyen'] = kieuVanChuyen;

    // check null tinhTrangSanPham
    if (tinhTrangSanPham != null) data['tinhTrangSanPham'] = tinhTrangSanPham;

    // check null idBangGiaPhiVanChuyen
    if (idBangGiaPhiVanChuyen != null) data['idBangGiaPhiVanChuyen'] = idBangGiaPhiVanChuyen;

    return data;
  }
}
